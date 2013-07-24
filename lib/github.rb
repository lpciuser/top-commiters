require "open-uri"
require "json"
require "active_support/core_ext/hash"
require_relative "github/improved_hash"
require_relative "github/client"
require_relative "github/user"
require_relative "github/repo"
require_relative "github/commit"


# 
# Root namespace for the project classes
# 
# @author Nikita Babushkin
# 
module GitHub; end