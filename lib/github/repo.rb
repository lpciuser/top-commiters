module GitHub
  
  class Repo
    attr_reader :user, :name

    def initialize(attr = {})
      attr.reverse_merge!(client: Client)

      @client = attr[:client]
      @user = attr[:user]
      @name = attr[:repo_name]
    end

    def path
      "repos/#{@user}/#{name}"
    end

    def commits
      commits! if @commits.nil?
      @commits
    end

    def commits!
      response = json("#{path}/commits")
      @commits = response.map do |commit| 
        Commit.new(client: @client, user: @user, repo: self, sha: commit.sha) 
      end
      @commits
    end

    def loaded?
      not @hash.nil?
    end

    def hash
      @hash ||= @client.get_hash(path)
      @hash
    end

    def method_missing(method, *args)
      hash.send(method, *args)
    end

    def to_s
      name
    end
  end
end