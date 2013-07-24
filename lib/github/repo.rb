module GitHub
  
  # 
  # This class will load and hold github repository data
  # 
  # @author Nikita Babushkin
  # 
  # @attr_reader [GitHub::User] user Author of the repository
  # @attr_reader [String] name Repository name
  # 
  # @example Basic usage
  #   user = GitHub::User.new(login:'octocat')
  #   repo = GitHub::Repo.new(user: user, repo_name: 'Hello-World')
  #   repo.commits # get the list of commits 
  class Repo
    attr_reader :user, :name


    # 
    # Creates a new Repo
    # 
    # @param  attr [Hash] a list of attributes
    # @option attr [GitHub::Client] :client (GitHub::Client) API connetction provider
    # @option attr [GitHub::User] :user repository holder
    # @option attr [String] :repo_name name of the repository
    def initialize(attr = {})
      attr.reverse_merge!(client: Client)

      @client = attr[:client]
      @user = attr[:user]
      @name = attr[:repo_name]
    end

    #
    # Generates api path for current repository
    # 
    # @return [String] API path for repo
    def path
      "repos/#{@user}/#{name}"
    end

    # 
    # Get the array of commits for current repository, loads remote data
    # if it's isn't loaded yet
    # 
    # @return [Array] List of GitHub::Commits
    def commits
      commits! if @commits.nil?
      @commits
    end

    # 
    # Load commits for current repository even if commits already loaded
    # 
    # @return [Array] List of GitHub::Commits
    def commits!
      response = json("#{path}/commits")
      @commits = response.map do |commit| 
        Commit.new(client: @client, user: @user, repo: self, sha: commit.sha) 
      end
      @commits
    end

    # 
    # Check if repository data is loaded
    # 
    # @return [Bool]
    def loaded?
      not @hash.nil?
    end

    #
    # Gets the repository data, loads remote data if it's isn't loaded yet
    # 
    # @return [Hash] [description]
    def hash
      @hash ||= @client.get_hash(path)
      @hash
    end

    # Proxy missing methods to contained hash
    def method_missing(method, *args)
      hash.send(method, *args)
    end

    # 
    # Casts self to string
    # 
    # @return [String] Repository name
    def to_s
      name
    end
  end
end