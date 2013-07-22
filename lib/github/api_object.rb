module GitHub
  module ApiObject
    API_BASE = "https://api.github.com"

    def get(path, options = {})
      request = @last_request = open("#{API_BASE}/#{path}")
      request
    end

    def json(path, options = {})
      request = get(path, options)
      JSON.parse(request.gets)
    end
  end
end