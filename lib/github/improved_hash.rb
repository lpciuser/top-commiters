module GitHub

  # 
  # Original ruby Hash wrapper with method-like acces to itself and subhashes
  # 
  # @author Nikita Babushkin
  # 
  class ImprovedHash

    # 
    # Creates a new ImprovedHash with given parameters
    # 
    # @param  source_hash [Hash] Source hash to recursively merge with self
    # @param  default [Number] Default value for new pairs
    def initialize(source_hash = nil, default = nil, &block) 
      @hash = default ? Hash.new(default) : Hash.new(&block)
      improve(source_hash, default, &block) unless source_hash.nil?
    end

    # 
    # Recursively merge source hash with self
    # 
    # @param  source_hash [Hash] Source hash to recursively merge with self
    # @param  default [Number] Default value for new pairs
    def improve(source_hash, default, &block)
      source_hash.each do |k, val|
        if val.is_a?(Hash)
          @hash[k] = self.class.new(val, default, &block)
        else
          @hash[k] = val
        end
      end
    end

    #
    # Compare self with other objects. 
    # If other_hash is not a ImprovedHash returns result of comparsion with hash
    # 
    # @param other_hash [Object] Object to compare with
    # @return [Bool]
    def ==(other_hash)
      if other_hash.is_a?(self.class)
        super
      else
        @hash == other_hash
      end
    end

    # 
    # If self and stored Hash wasn't respond to method 
    # it returns hash value with key == method.to_s
    # 
    # @param  method [Symbol] Method name
    # @param  args [Array] Arguments passed to method
    # 
    # @return [Object] stored hash method output or value of the key
    def method_missing(method, *args)
      if @hash.respond_to?(method)
        @hash.send(method, *args)
      elsif @hash.has_key?(method.to_s)
        @hash[method.to_s]
      else
        super
      end
    end
  end
end