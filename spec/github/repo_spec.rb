require "github"

describe GitHub::Repo do
  before do
    hash = GitHub::ImprovedHash.new("foo" => { "bar" => "baz" }, "qux" => "quux")
    fake_client = double('client', get_hash: hash)
    @repo = described_class.new(client: fake_client, user: 'octocat', repo_name: 'Hello-World')  
  end
  subject { @repo }

  it { should respond_to(:user) }
  it { should respond_to(:name) }
  it { should respond_to(:commits) }
  its(:user) { should eq('octocat') }  

  it_should_behave_like "a github API object" do 
    let(:object) { @repo }
  end
end