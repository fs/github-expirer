require 'active_support/core_ext/string/inflections'

class Hash
  def underscore_keys!
    keys.each do |key|
      self[key.underscore] = delete(key)
    end

    self
  end
end
