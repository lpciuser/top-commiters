module GitHub

  class ImprovedHash < Hash

    def initialize(source_hash = nil, default = nil, &block)
      improve(source_hash, default, &block) if source_hash.is_a?(Hash)
      default ? super(default) : super(&block)
    end

    alias_method :set_value, :[]=
    alias_method :get_value, :[]

    def improve(source_hash, default, &block)
      source_hash.each do |k, val|
        if val.is_a?(Hash)
          set_value(k, self.class.new(val, default, &block))
        else
          set_value(k, val)
        end
      end
    end

    def method_missing(method, *args)
      if has_key?(method.to_s)
        get_value(method.to_s)
      else
        super
      end
    end
  end
end