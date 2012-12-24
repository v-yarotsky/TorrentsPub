require 'spec_helper'
require 'torrents_pub/scrape/authentication_proxy'

module TorrentsPub::Scrape
  describe AuthenticationProxy do
    class NullAuthenticationProxy < AuthenticationProxy
      attr_accessor :logged_in, :logged_out
      def login;  @logged_in  = true; end
      def logout; @logged_out = true; end
    end

    before(:each) do
      @subject = double(:Scraper, foo: :bar)
      @proxy = NullAuthenticationProxy.new(@subject)
    end

    it "should delegate any call to subject wrapping it with login and logout" do
      @proxy.foo.should == :bar
      @proxy.logged_in.should be_true
      @proxy.logged_out.should be_true
    end

    it "should logout if anything raised" do
      @subject.should_receive(:foo).and_raise(StandardError)
      expect { @proxy.foo.should == :bar }.to raise_error(StandardError)
      @proxy.logged_in.should be_true
      @proxy.logged_out.should be_true
    end
  end
end

