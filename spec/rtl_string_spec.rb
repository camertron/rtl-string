# encoding: UTF-8

require "spec_helper"

describe String do
  describe "#to_rtl_s" do
    it "should return an instance of RtlString" do
      "abc".to_rtl_s.should be_a(RtlString)
    end
  end
end

describe RtlString do
  let(:str) do
    [
      1602, 1575, 1605,
      32, 98, 108, 97, 114, 103, 32,
      1576, 1573, 1590, 1575, 1601, 1578, 1603,
    ].pack("U*")
  end

  let(:representation) do
    "[qaf][alef][meem] blarg [beh][alef - hamza below][dad][alef][feh][teh][kaf]"
  end

  before(:each) do
    @rtl_str = RtlString.new(str)
  end

  describe "#to_s" do
    it "should correctly display rtl characters in byte order and with placeholders" do
      @rtl_str.to_s.should == representation
    end
  end

  describe "#inspect" do
    it "uses to_s to represent the string" do
      @rtl_str.inspect.should == "#<RtlString:0x#{@rtl_str.object_id.to_s(16)} \"#{representation}\">"
    end
  end

  describe "#delete_at" do
    it "removes characters from the string" do
      @rtl_str.delete_at(2).to_s.should == "[meem]"
      @rtl_str.to_s.should == "[qaf][alef] blarg [beh][alef - hamza below][dad][alef][feh][teh][kaf]"
    end
  end

  describe "#delete_range" do
    it "removes a range of characters from the string" do
      @rtl_str.delete_range(10..12).should be_nil
      @rtl_str.to_s.should == "[qaf][alef][meem] blarg [alef][feh][teh][kaf]"
    end
  end

  describe "#insert" do
    it "inserts characters into the string" do
      @rtl_str.insert([1576].pack("U*"), 2).should eql(@rtl_str)
      @rtl_str.to_s.should == "[qaf][alef][beh][meem] blarg [beh][alef - hamza below][dad][alef][feh][teh][kaf]"
    end
  end

  describe "#[]" do
    it "retrieves the character at the specified index" do
      @rtl_str[2].tap do |char|
        char.should be_a(RtlString)
        char.to_s.should == "[meem]"
      end
    end

    it "retrieves a range of characters" do
      @rtl_str[2..5].tap do |chars|
        chars.should be_a(RtlString)
        chars.to_s.should == "[meem] bl"
      end
    end
  end

  describe "#size" do
    it "returns the length of the string by number of actual chars" do
      @rtl_str.size.should == 17
    end
  end

  describe "#length" do
    it "returns the length of the string by number of actual chars" do
      @rtl_str.length.should == 17
    end
  end
end