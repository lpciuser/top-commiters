require "github"

describe GitHub::Commit do
  before do 
    hash = GitHub::ImprovedHash.new("foo" => { "bar" => "baz" }, "qux" => "quux")
    fake_client = double('client', get_hash: hash)
    @commit = described_class.new(client: fake_client, user: "octocat", 
      repo: "Hello-World", sha: "6dcb09b5b57875f334f61aebed695e2e4193db5e" )
  end
  subject { @commit }

  it { should respond_to(:user) }
  it { should respond_to(:repo) }
  it { should respond_to(:sha) }

  its(:user) { should eq('octocat') }
  its(:repo) { should eq('Hello-World') }
  its(:sha) { should eq('6dcb09b5b57875f334f61aebed695e2e4193db5e') }
  
  it_should_behave_like "a github API object" do 
    let(:object) { @commit }
  end
end