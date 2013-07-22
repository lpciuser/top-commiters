require "spec_helper"
require "github"
include GitHub

describe ImprovedHash do
  let(:source_hash) do 
    {
      'foo' => { 
        'bar' => { 'baz' => "baz_value" }, 
        'qux' => "qux_value" 
      }, 
      'bar' => "baz_value" 
    }
  end

  context "when initialized with source hash" do 
    let(:improved_hash) { ImprovedHash.new(source_hash) }

    it "should provide method-like access to hash and all subhashes" do
      expect(improved_hash.foo).to eq improved_hash['foo']
      expect(improved_hash.foo.bar).to eq improved_hash['foo']['bar']
      expect(improved_hash.foo.bar.baz).to eq improved_hash['foo']['bar']['baz']
    end

    it "should not support method-like access for symbolic keys" do
      improved_hash[:quux] = "value of symbolic key"
      expect { improved_hash.quux }.to raise_error(NoMethodError)
    end

    it "should == original Hash" do
      expect(improved_hash).to eq(source_hash)
    end
  end

  context "when initialized with default value" do
    let(:improved_hash) { ImprovedHash.new(source_hash, 42) }

    it "should provide default value to created pairs" do
      expect(improved_hash['new_key']).to eq(42)
    end
  end

  context "when initialized with a block" do
    let(:improved_hash) { ImprovedHash.new { |h, k| h[k] = "my key is #{k}" } }

    it "should yield for default value" do
      expect(improved_hash["foo"]).to eq "my key is foo"
      expect(improved_hash["bar"]).to eq "my key is bar"
    end    
  end
end