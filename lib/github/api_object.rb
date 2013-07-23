module GitHub
  module ApiObject
    API_BASE = "https://api.github.com"

    def get(path, options = {})
      request = @last_request = open("#{API_BASE}/#{path}")
      request
    end

    def json(path, options = {})
      request = get(path, options)
      ImprovedHash.new(JSON.parse(request.gets))
    end

    def loaded?
      not @hash.nil?
    end

    def hash
      @hash ||= json(path)# if @hash.nil?
      @hash
    end

    def method_missing(*args)
      hash.send(*args)
    end
  end
end