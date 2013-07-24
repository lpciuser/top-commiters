module GitHub
  module Utils

    # 
    # Class for building ratings on values of the deep item key 
    # by the values of the deep item key based on list of Hashes
    # 
    # @author Nikita Babushkin
    # 
    # @attr_reader source [Object] Source passed into constructor
    # 
    # @example Building rating on array of hashes
    #   ary = [ 
    #     { "foo" => {"bar" => 42 }, "baz" => "foo" },
    #     { "foo" => {"bar" => 12 }, "baz" => "bar" },
    #     { "foo" => {"bar" => 9 }, "baz" => "foo" }
    #     { "baz" => "qux" },
    #   ]
    #   
    #   rating = Rating.new(ary)
    #   ratin.build(subject: ["baz"], target: ["foo", "bar"])
    #   # output: { "foo" => 51, "bar" => 12, "qux" => 0 }
    # @example With default value for rating
    #   rating = Rating.new(ary)
    #   ratin.build(subject: ["baz"], target: ["foo", "bar"], default: 100)
    #   # output: { "foo" => 151, "bar" => 112, "qux" => 100 }
    # @example Building with block
    #   rating = Rating.new(ary)
    #   ratin.build(subject: ["baz"], target: ["foo", "bar"]) do |sum, value|
    #     sum + (value - 1)
    #   end
    #   # output: { "foo" => 49, "bar" => 11, "qux" => -1 }
    class Rating
      
      attr_reader :source

      # 
      # Creates new Rating instance
      # @param  source [Object] Enumerable with list of objects
      def initialize(source)
        @source = source
      end
     
      # 
      # Builds a rating based on source and specified parameters
      # @param  args [Hash] arguments list
      # @option args [Array] :subject Array of keys for deep subject search
      # @option args [Array] :target ([]) Array of keys for deep value search
      # @option args [Number] :default (0) Default value for new rating keys
      # 
      # @return [Hash] Hash with ratings
      def build(args = {}, &block)
        args.reverse_merge!(default: 0, target: [])
        rating = Hash.new(args[:default])

        @source.each do |n|      
          subject = deep_key(n, args[:subject])
          value = deep_key(n, args[:target])            
          if block_given?
            rating[subject] = yield(rating[subject], value)
          else
            rating[subject] = sum(rating[subject], value)
          end
        end
      
        rating
      end
     

      # 
      # Search keys in nested hashes struct and return it's value 
      # or nil if given path doesn't exists
      # 
      # @param  hash [Hash] source hash for values search
      # @param  keys [type] [description]
      # 
      # @return [Object] Value of the give key struct
      # @return [NilClass] if given keypath doesn't exists
      # @return [Object] Object passed as first parameter if second wasn't speciefied
      def deep_key(hash, keys = [])
        return hash if keys.size == 0
     
        value = hash
        keys.each do |k|
          value = value[k]
          break unless value.respond_to?(:[])
        end
        value
      end
      
      # 
      # Sum of two arguments. If num can't coerce object 
      # return num + 0 for nil and num + 1 for any other object
      # 
      # @param  num [Number] Left part of +
      # @param  object [Object] Right part of +
      # 
      # @return [Object] object of num class
      def sum(num, object)
        begin
          num + object
        rescue TypeError
          if object == nil
            num + 0
          else       
            num + 1
          end
        end
      end
    end
  end
end