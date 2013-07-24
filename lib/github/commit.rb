module GitHub
  
  #
  # This class will load and hold github commit data
  # 
  # @author Nikita Babushkin
  # 
  # @attr_reader user [GitHub::User] Author of commit provided to coonstructor
  # @attr_reader repo [GitHub::Repo] Repository provided to constructor
  # @attr_reader sha [String] sha-identifier of commit provided to constructor
  # 
  # @example Create a GitHub::Commit instance
  #   user = GitHub::User.new('octocat')
  #   repo = user.repo('Hello-World')
  #   commit = GitHub::Commit.new(user: user, repo: repo, sha: '6dcb09b5b57875f334f61aebed695e2e4193db5e')
  class Commit
    attr_reader :user, :repo, :sha

    # 
    # Creates a new commit.
    # 
    # @param  attr [Hash] a list of attributes
    # @option attr [GitHub::Client] :client (GitHub::Client) API connetction provider
    # @option attr [GitHub::User] :user Author of the commit
    # @option attr [GitHub::Repo] :repo Repository which contains commit
    # @option attr [String] :sha Commit identifier
    def initialize(attr = {})
      attr.reverse_merge!(client: Client)

      @client = attr[:client]
      @user = attr[:user]
      @repo = attr[:repo]
      @sha = attr[:sha]
    end

    #
    # Generate api path for current commit
    # 
    # @return [String] API path for commit
    def path
      "repos/#{user}/#{repo}/commits/#{sha}"
    end

    # 
    # Check if commit data is loaded
    # 
    # @return [Bool]
    def loaded?
      not @hash.nil?
    end
    
    #
    # Gets the commit data, loads remote data if it's isn't loaded yet
    # 
    # @return [Hash] [description]
    def hash
      @hash ||= @client.get_hash(path)
      @hash
    end

    #
    # Proxy missing methods to contained hash
    def method_missing(method, *args)
      hash.send(method, *args)
    end

    # 
    # Casts self to string
    # 
    # @return [String] Commit sha identifier
    def to_s
      sha
    end
  end
end