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
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        var_value = instance_variable_get("@#{validation[:attribute]}")

        case validation[:validation_type]
        when :presence
          if var_value.nil? || var_value == ''
            raise "#{validation[:attribute]} nil or empty string"
          end
        when :type
          unless var_value.instance_of? validation[:validation_attr]
            raise "Wrong class for #{validation[:attribute]},
                   should be #{validation[:validation_attr]}"
          end
        when :format
          if var_value !~ validation[:validation_attr]
            raise "Wrong format #{var_value} for #{validation[:attribute]}
                  format: #{validation[:validation_attr]}"
          end
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
