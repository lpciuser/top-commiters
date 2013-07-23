module GitHub
  
  class User
    attr_reader :login

    def initialize(attr = {})
      attr.reverse_merge!(client: Client)

      @client = attr[:client]
      @login = attr[:login]
    end

    def path
      "users/#{@login}"
    end

    def repo(repo_name)
      Repo.new(client: @client, user: self, repo_name: repo_name)
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
      login
    end
  end
end