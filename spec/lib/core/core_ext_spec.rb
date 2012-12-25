require 'spec_helper'

describe Object do
  specify "#debug_message should puts given message to stderr together with issuer class name and object id" do
    obj = Object.new
    STDERR.should_receive(:puts).with("DBG (Object##{obj.object_id}): chunky bacon")
    obj.debug_message("chunky bacon")
  end
end

describe Class do
  describe "#inheritable_class_attribute" do
    before(:each) do
      @playground = Class.new do
        inheritable_class_attribute :foo
      end
    end

    it "should be nil by default" do
      @playground.foo.should be_nil
    end

    it "should allow defining default value" do
      @playground.class_eval do
        inheritable_class_attribute :bar, :default => 3
      end
      @playground.bar.should == 3
    end

    it "should define a getter and setter on the class" do
      @playground.foo = 1
      @playground.foo.should == 1
    end

    it "should be inheritable" do
      @playground.foo = 1
      @sandbox = Class.new(@playground)
      @sandbox.foo.should == 1
    end

    it "should not alter parent's class attribute" do
      @playground.foo = 1
      @sandbox = Class.new(@playground)
      @sandbox.foo = 2
      @playground.foo.should == 1
      @sandbox.foo.should == 2
    end
  end

  specify "#abstract_method should add method raising NotImplementedError" do
    @playground = Class.new do
      abstract_method :badumts
    end
    expect { @playground.new.badumts }.to raise_error(NotImplementedError)
  end
end

