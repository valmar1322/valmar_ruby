# frozen_string_literal: true

module Validator
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(attribute, validation_type, validation_attr = '')
      validations << {
        attribute: attribute,
        validation_type: validation_type,
        validation_attr: validation_attr
      }
    end

    private

    def validation_presence(value, **validation)
      value.nil? || value == ''
    end

    def validation_type(value, **validation)
      !value.instance_of? validation[:validation_attr]
    end

    def validation_format(value, **validation)
      value !~ validation[:validation_attr]
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        var_value = instance_variable_get("@#{validation[:attribute]}")
        
        validation_method = "validation_#{validation[:validation_type]}".to_sym

        result = self.class.send(validation_method, var_value, validation)
        if result
          raise "validation error! method: #{validation_method}, field: #{validation[:attribute]},
                 value: #{var_value}"
        end
      end
    end

    def valid?
      validate!
      true
    rescue RuntimeError => e
      puts e.message
      false
    end
  end
end

# class Test
#   include Validator
#   validate :first_name, :presence
#   validate :first_name, :type, String
#   validate :first_name, :format, /^[A-Z]*$/

#   def initialize(name = 'vladimir')
#     @first_name = name
#     validate!
#   end
# end
