module GitHub
  
  class User
    include ApiObject
    attr_reader :login

    def initialize(*args)
      case args[0]
        when Hash
          @hash = args[0]
          @login = @hash['login']
        when String
          @login = args[0]
        else
          raise ArgumentError
      end
    end

    def path
      "users/#{@login}"
    end

    def repo(repo_name)
      Repo.new(self, repo_name)
    end

    def to_s
      login
    end
  end
end