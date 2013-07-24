module GitHub

  # 
  # This class provides github connection and methods to perform API requests
  # 
  # @author Nikita Babushkin
  # 
  class Client

    # Represents base url for github API request
    API_BASE = "https://api.github.com"
    
    # 
    # Perform an API call based on given path
    # 
    # @param  path [String] Path for API call
    # @param  options [Hash] For now it's just a placeholder
    # 
    # @return [Tempfile] File-like network stream for given path
    def self.get(path, options = {})
      request = @last_request = open("#{API_BASE}/#{path}")
    end


    # 
    # Performs an API call and wraps the output into Hash
    # 
    # @param  path [String] Path for API call
    # @param  options [Hash] For now it's just a placeholder
    # 
    # @return [GitHub::ImprovedHash] Hash with requested data
    def self.get_hash(path, options = {})
      request = get(path, options)
      ImprovedHash.new(JSON.parse(request.gets))
    end
  end
end