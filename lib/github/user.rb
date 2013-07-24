module GitHub
  
  # 
  # This class will load and hold github user data
  # 
  # @author Nikita Babushkin
  # 
  # @attr_reader [String] login Login of the GitHub user
  # 
  # @example Basic usage
  #   user = GitHub::User.new(login: 'octocat')
  #   user.id # access github user data
  #   repo = user.repo('Hello-World') # create GitHub::Repo for user's Hello-World repository
  class User
    attr_reader :login

    # 
    # Creates a new user
    # 
    # @param  attr [Hash] a list of attributes
    # @option attr [GitHub::Client] :client (GitHub::Client) API connetction provider
    # @option attr [String] :login login of the GitHub user
    # 
    def initialize(attr = {})
      attr.reverse_merge!(client: Client)

      @client = attr[:client]
      @login = attr[:login]
    end

    #
    # Generate api path for current user
    # 
    # @return [String] API path for user
    def path
      "users/#{@login}"
    end


    # 
    # Gets Github::Repository for current user
    # @param  repo_name [String] The name of one of user's repository
    # 
    # @return [GitHub::Repo] GitHub repository
    def repo(repo_name)
      Repo.new(client: @client, user: self, repo_name: repo_name)
    end

    # 
    # Check if user data is loaded
    # 
    # @return [Bool]
    def loaded?
      not @hash.nil?
    end

    #
    # Gets the user data, loads remote data if it's isn't loaded yet
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
    # @return [String] Login of the current user
    def to_s
      login
    end
  end
end