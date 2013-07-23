module GitHub

  class ImprovedHash

    def initialize(source_hash = nil, default = nil, &block) 
      @hash = default ? Hash.new(default) : Hash.new(&block)
      improve(source_hash, default, &block) unless source_hash.nil?
    end

    def improve(source_hash, default, &block)
      source_hash.each do |k, val|
        if val.is_a?(Hash)
          @hash[k] = self.class.new(val, default, &block)
        else
          @hash[k] = val
        end
      end
    end

    def ==(other_hash)
      if other_hash.is_a?(self.class)
        super
      else
        @hash == other_hash
      end
    end

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