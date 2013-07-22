module GitHub
  
  class Commit
    include ApiObject
    attr_reader :user, :repo, :hash, :sha

    def initialize(*args)
      case args[0]
        when Hash
          @user = User.new(args[0]['author'])        
          @repo = Repo.new(@user, args[1])
          @hash = args[0]
          @sha = @hash['sha']
        when String
          params = args[0].split("/")
          @user = User.new(params[0])
          @repo = Repo.new(@user, params[1])
          @sha = params[2]
        else
          raise ArgumentError
      end
    end

    def path
      "repos/#{user}/#{repo}/commits/#{sha}"
    end

    def hash
      @hash = json(path) if @hash.nil?
      @hash
    end

    def to_s
      sha
    end
  end
end