require "spec_helper"
require "github"
include GitHub

describe User do
  let(:user) { User.new('octocat') }
  subject { user }
  let(:user_json_string) do
    %({
        "login": "octocat",
        "id": 1,
        "avatar_url": "https://github.com/images/error/octocat_happy.gif",
        "gravatar_id": "somehexcode",
        "url": "https://api.github.com/users/octocat",
        "name": "monalisa octocat",
        "company": "GitHub",
        "blog": "https://github.com/blog",
        "location": "San Francisco",
        "email": "octocat@github.com",
        "hireable": false,
        "bio": "There once was...",
        "public_repos": 2,
        "public_gists": 1,
        "followers": 20,
        "following": 0,
        "html_url": "https://github.com/octocat",
        "created_at": "2008-01-14T04:33:35Z",
        "type": "User",
        "total_private_repos": 100,
        "owned_private_repos": 100,
        "private_gists": 81,
        "disk_usage": 10000,
        "collaborators": 8,
        "plan": {
          "name": "Medium",
          "space": 400,
          "collaborators": 10,
          "private_repos": 20
        }
      })
  end

  let(:user_hash) { ImprovedHash.new(JSON.parse(user_json_string)) }
  before { user.stub(:json).with(/users\/octocat/).and_return(user_hash) }

  it { should respond_to :login }
  it { should respond_to :repo }

  it "should provide method-like access to @hash" do
    user.hash.each do |k, val|
      expect(user.send(k)).to eq(val)
    end
  end

  context "when initialized with user_hash" do 
    let(:user) { User.new(user_hash) }

    it "should not load remote data" do 
      user.stub(:json).and_return("{}")

      user.hash.should eq(user_hash)
    end
  end
end