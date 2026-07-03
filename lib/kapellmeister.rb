module Kapellmeister; end

class Object
  def deep_compact
    self
  end

  def deep_compact!
    self
  end
end

class Array
  def deep_compact
    filter_map(&:deep_compact)
  end

  def deep_compact!
    map!(&:deep_compact!).compact!
  end
end

class Hash
  def deep_compact
    each_with_object({}) do |(key, value), hash|
      if value == false
        hash[key] = false
      elsif (new_value = value.deep_compact)
        hash[key] = new_value
      end
    end
  end

  def deep_compact!
    keys.each do |key|
      value = self[key]

      if value == false
        self[key] = false
      elsif (new_value = value.deep_compact)
        self[key] = new_value
      else
        delete(key)
      end
    end
  end
end

require 'kapellmeister/base'
require 'kapellmeister/dispatcher'
require 'kapellmeister/requests_extension'
require 'kapellmeister/responder'
