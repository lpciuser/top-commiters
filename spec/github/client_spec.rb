require "spec_helper"
require "github"

describe GitHub::Client do
  it "should provide class method :get_hash" do
    described_class.should respond_to(:get_hash)
  end

  it "should provide API_BASE constant with secure url" do
    expect(described_class::API_BASE).to match(/^https.+/)
  end
end