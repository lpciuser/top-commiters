module GitHub

  # 
  # This class provides github connection and methods to perform API requests
  # 
  # @author Nikita Babushkin
  # 
  class Client

    # Represents base url for github API request
    API_BASE = "https://api.github.com"
    #API access token
    TOKEN = '88659f78f6a2fae0a091de0c51b5a60342b546ef'
    # 
    # Perform an API call based on given path
    # 
    # @param  path [String] Path for API call
    # @param  options [Hash] For now it's just a placeholder
    # 
    # @return [Tempfile] File-like network stream for given path
    def self.get(path, options = {})
      request = @last_request = open("#{API_BASE}/#{path}?access_token=#{TOKEN}")
    end

    # 
    # Performs an API call and parse response as JSON
    # 
    # @param  path [String] Path for API call
    # @param  options [Hash] For now it's just a placeholder
    # 
    # @return [Object] Output of JSON.parse
    def self.get_json(path, options = {})
      request = get(path, options)
      JSON.parse(request.gets)
    end

    # 
    # Performs an API call and wraps the output into Hash
    # 
    # @param  path [String] Path for API call
    # @param  options [Hash] For now it's just a placeholder
    # 
    # @return [GitHub::ImprovedHash] Hash with requested data
    def self.get_hash(path, options = {})
      ImprovedHash.new(get_json(path, options))
    end
  end
end