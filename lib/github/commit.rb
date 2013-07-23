module GitHub
  
  class Commit
    attr_reader :user, :repo, :sha

    def initialize(attr = {})
      attr.reverse_merge!(client: Client)

      @client = attr[:client]
      @user = attr[:user]
      @repo = attr[:repo]
      @sha = attr[:sha]
    end

    def path
      "repos/#{user}/#{repo}/commits/#{sha}"
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
      sha
    end
  end
end