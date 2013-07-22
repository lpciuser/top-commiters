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

    def hash
      @hash = json(path) if @hash.nil?
      @hash
    end

    def repo(repo_name)
      Repo.new(self, repo_name)
    end

    def method_missing(method, *args)
      method_string = method.to_s

      if hash.has_key?(method_string)
        hash[method_string]
      else
        super
      end
    end

    def to_s
      login
    end
  end
end