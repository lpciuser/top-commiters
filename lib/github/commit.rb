module GitHub
  
  class Commit
    include ApiObject
    attr_reader :user, :repo, :sha

    def initialize(user, repo, sha)
      @user = user
      @repo = repo
      @sha = sha
    end

    def path
      "repos/#{user}/#{repo}/commits/#{sha}"
    end

    def to_s
      sha
    end
  end
end