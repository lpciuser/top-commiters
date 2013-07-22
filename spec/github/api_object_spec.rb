require "spec_helper"
require "github"
include GitHub
class FakeClass; end

describe ApiObject do
  let(:klass) { FakeClass.new.extend(ApiObject) }
  subject { klass.extend(ApiObject) }

  it { should respond_to(:get) }
  it { should respond_to(:json) }

  it "should provide API_BASE constant with API base url" do
    expect(ApiObject::API_BASE).to match(/^https:\/\/.+/)
  end
end