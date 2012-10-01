# encoding: utf-8
require 'uri'
require 'spec_helper'
require 'slapjack/trackers/torrents_by/scraper'

module Slapjack
  module Trackers
    describe TorrentsByTracker::Scraper::TorrentParser do
      it "should parse row" do
        row = stub_row("text", :attr => "./href")
        parser(row).attributes.should == {
          :tracker_section     => "text",
          :title               => "text",
          :size                => 0,
          :seeders             => 0,
          :link                => "http://example.com/cat/href",
          :tracker_link        => "http://example.com/cat/href"
        }
      end

      it "should parse size correctly" do
        row = stub_row("2.19 GB")
        parser(row).size.should == 2.19 * 1024 ** 3

        row = stub_row("3 MB")
        parser(row).size.should == 3 * 1024 ** 2
      end

      def parser(row)
        described_class.new(row, URI.join("http://example.com", '/cat/'))
      end

      def stub_row(text, other = {})
        stub(:at_css => stub(other.merge(:text => text)))
      end
    end

    describe TorrentsByTracker::Scraper do
      class FakeAgent; end

      before(:each) do
        @agent   = FakeAgent.new
        @scraper = TorrentsByTracker::Scraper.new(@agent, ["foo and bar"])
      end

      specify "#fetch_torrents" do
        @agent.should_receive(:visit_url).with(URI.parse("http://torrents.by/forum/tracker")).ordered

        tracker_form = mock("Tracker form").tap do |f|
          foo_and_bar_tracker_section_option = mock(text: "foo and bar").tap { |opt| opt.should_receive(:tick) }
          badumts_tracker_section_option     = mock(text: "badumts").tap { |opt| opt.should_not_receive(:tick) }
          f.should_receive(:field).with('f[]').and_return(stub(:options => [foo_and_bar_tracker_section_option, badumts_tracker_section_option]))

          period_today_option = mock.tap { |opt| opt.should_receive(:select) }
          period_dropdown     = mock.tap { |d| d.should_receive(:option_with).with(text: /сегодня/i).and_return(period_today_option) }
          f.should_receive(:field).with('tm').and_return(period_dropdown)

          seeders_checkbox, show_tracker_section_checkbox = mock, mock
          [seeders_checkbox, show_tracker_section_checkbox].each { |c| c.should_receive(:check) }
          macro_tracker_section_checkbox = mock.tap { |c| c.should_receive(:uncheck) }

          f.should_receive(:checkbox).with('sd').and_return(seeders_checkbox)
          f.should_receive(:checkbox).with('dc').and_return(macro_tracker_section_checkbox)
          f.should_receive(:checkbox).with('df').and_return(show_tracker_section_checkbox)

          f.should_receive(:submit)
        end

        @agent.should_receive(:form_with).with(name: "post").ordered.and_yield(tracker_form).and_return(tracker_form)

        row = stub("Result row 1")
        TorrentsByTracker::Scraper::TorrentParser.should_receive(:new).with(row).and_return(stub(title: "foo", attributes: { foo: :bar }))
        @agent.should_receive(:search).with('.//tr[contains(@class, "tCenter")]').ordered.and_return([row])

        next_link = mock.tap { |a| a.should_receive(:click) }
        @agent.should_receive(:link_with).with(text: "След.").ordered.and_return(next_link)

        row2 = stub("Result row 2")
        TorrentsByTracker::Scraper::TorrentParser.should_receive(:new).with(row2).and_return(stub(title: "bar", attributes: { boo: :baz }))
        @agent.should_receive(:search).with('.//tr[contains(@class, "tCenter")]').ordered.and_return([row2])

        @agent.should_receive(:link_with).with(text: "След.").ordered.and_return(nil)

        @scraper.fetch_torrents.should == [{ foo: :bar}, { boo: :baz }]
      end
    end
  end
end

