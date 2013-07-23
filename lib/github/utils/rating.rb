module GitHub
  module Utils
    class Rating
      
      attr_reader :source

      def initialize(source)
        @source = source
      end
     
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
     
      def deep_key(hash, keys = [])
        return hash if keys.size == 0
     
        value = hash
        keys.each do |k|
          value = value[k]
          break unless value.respond_to?(:[])
        end
        value
      end
     
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