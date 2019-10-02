# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*methods)
      methods.each do |method|
        define_method(method) { instance_variable_get("@#{method}") }

        history_var_name = "@#{method}_history"

        define_method("#{method}_history") do
          instance_variable_get(history_var_name)
        end

        define_method("#{method}=") do |v|
          if instance_variable_get(history_var_name).nil?
            instance_variable_set(history_var_name, [])
          else
            instance_variable_get(history_var_name) << instance_variable_get("@#{method}")
          end

          instance_variable_set("@#{method}", v)
        end
      end
    end

    def strong_attr_accessor(method, class_name)
      define_method(method) { instance_variable_get("@#{method}") }
      define_method("#{method}=") do |v|
        raise TypeError, "Wrong class for #{method}" unless v.instance_of? class_name

        instance_variable_set("@#{method}", v)
      end
    end
  end

  module InstanceMethods
  end
end

# class Test
#   include Accessors

#   attr_accessor_with_history :first_name
#   strong_attr_accessor :second_name, String
#   strong_attr_accessor :age, Integer
# end
