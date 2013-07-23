module GitHub
  
  class Repo
    include ApiObject
    attr_reader :user, :name

    def initialize(*args)
      case args[0]
        when Hash
          @user, @name = User.new(args[0][:owner]), args[0][:repo]
        when User
          @user, @name = args[0],args[1]
        when String
          params = args[0].split('/')
          @user, @name = User.new(params[0]), params[1]
        else
          raise ArgumentError
      end
    end

    def path
      "repos/#{@user}/#{name}"
    end

    def commits
      commits! if @commits.nil?
    end

    def commits!
      response = json("#{path}/commits")
      @commits = response.map do |commit| 
        Commit.new(@user, self, commit.sha) 
      end
    end

    def to_s
      name
    end
  end
end