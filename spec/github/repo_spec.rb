require "spec_helper"
require "github"
include GitHub

describe Repo do
  context "when initialized with string" do
    let(:repo) { Repo.new("octocat/Hello-World") }
    subject { repo }

    it { should respond_to(:user) }
    it { should respond_to(:name) }
    
    context "#user" do
      subject { repo.user }

      it { should be_a_kind_of(User) }
      its(:login) { should eq("octocat") }  
    end
  end

  context "when initialized with GitHub::User and name string" do
    let(:user) { User.new("octocat") }
    let(:repo) { Repo.new(user, "Hello-World") }
    subject { repo }

    it { should respond_to(:user) }
    it { should respond_to(:name) }
    
    context "#user" do
      subject { repo.user }

      it { should be_a_kind_of(User) }
      its(:login) { should eq("octocat") }  
    end
  end

  context "when initialized with Hash" do
    let(:repo) { Repo.new(owner: "octocat", repo: "Hello-World") }
    subject { repo }

    it { should respond_to(:user) }
    it { should respond_to(:name) }
    
    context "#user" do
      subject { repo.user }

      it { should be_a_kind_of(User) }
      its(:login) { should eq("octocat") }  
    end
  end

  context "when initialized with unsupported parameter set" do
    it "should raise ArgumentError" do
      expect { Repo.new(42) }.to raise_error(ArgumentError)
    end
  end
end