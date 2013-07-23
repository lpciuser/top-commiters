require "spec_helper"
require "github"
include GitHub

describe Commit do
  let(:commit_json_string) do
    %({
      "url": "https://api.github.com/repos/octocat/Hello-World/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "sha": "6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "commit": {
        "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e",
        "author": {
          "name": "Monalisa Octocat",
          "email": "support@github.com",
          "date": "2011-04-14T16:00:49Z"
        },
        "committer": {
          "name": "Monalisa Octocat",
          "email": "support@github.com",
          "date": "2011-04-14T16:00:49Z"
        },
        "message": "Fix all the bugs",
        "tree": {
          "url": "https://api.github.com/repos/octocat/Hello-World/tree/6dcb09b5b57875f334f61aebed695e2e4193db5e",
          "sha": "6dcb09b5b57875f334f61aebed695e2e4193db5e"
        }
      },
      "author": {
        "login": "octocat",
        "id": 1,
        "avatar_url": "https://github.com/images/error/octocat_happy.gif",
        "gravatar_id": "somehexcode",
        "url": "https://api.github.com/users/octocat"
      },
      "committer": {
        "login": "octocat",
        "id": 1,
        "avatar_url": "https://github.com/images/error/octocat_happy.gif",
        "gravatar_id": "somehexcode",
        "url": "https://api.github.com/users/octocat"
      },
      "parents": [
        {
          "url": "https://api.github.com/repos/octocat/Hello-World/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e",
          "sha": "6dcb09b5b57875f334f61aebed695e2e4193db5e"
        }
      ],
      "stats": {
        "additions": 104,
        "deletions": 4,
        "total": 108
      },
      "files": [
        {
          "filename": "file1.txt",
          "additions": 10,
          "deletions": 2,
          "changes": 12,
          "status": "modified",
          "raw_url": "https://github.com/octocat/Hello-World/raw/7ca483543807a51b6079e54ac4cc392bc29ae284/file1.txt",
          "blob_url": "https://github.com/octocat/Hello-World/blob/7ca483543807a51b6079e54ac4cc392bc29ae284/file1.txt"
        }
      ]
    })
  end
  let(:commit_hash) { ImprovedHash.new(JSON.parse(commit_json_string)) } 
  let(:commit) { Commit.new("octocat", "Hello-World", "commit_sha") }
  before { commit.stub(:json).and_return(commit_hash) }
  subject { commit }

  it { should respond_to(:user) }
  it { should respond_to(:repo) }
  it { should respond_to(:sha) }
  
  it "should lazy-load commit data" do 
    expect(commit).not_to be_loaded
    commit.hash
    expect(commit).to be_loaded
  end
end