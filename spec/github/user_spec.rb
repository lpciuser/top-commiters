require "github"

describe GitHub::User do

  before do     
    hash = GitHub::ImprovedHash.new("foo" => { "bar" => "baz" }, "qux" => "quux")
    fake_client = double('client', get_hash: hash)
    @user = described_class.new(login: 'octocat', client: fake_client)
  end
  subject { @user }

  it { should respond_to :login }
  it { should respond_to :repo }

  it_should_behave_like "a github API object" do 
    let(:object) { @user }
  end
end