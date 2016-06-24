class Hash
  def to_param_keys
    self.inject({}) { |m, (k, v)| m[k.gsub(' ', '_').to_sym] = v; m }
  end

  def to_methods
    hash = self
    Module.new do
      hash.each_pair do |key, value|
        define_method key.underscore do
          value
        end
        define_method("#{key.underscore}=") do |val|
          instance_variable_set("@#{key.underscore}", val)
        end
      end
    end
  end

end