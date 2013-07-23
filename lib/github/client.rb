module GitHub
  class Client
    API_BASE = "https://api.github.com"
    
    def self.get(path, options = {})
      request = @last_request = open("#{API_BASE}/#{path}")
    end

    def self.get_hash(path, options = {})
      request = get(path, options)
      ImprovedHash.new(JSON.parse(request.gets))
    end
  end
end