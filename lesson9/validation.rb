# frozen_string_literal: true

module Validation
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, type, arg = "")
      self.validations ||= []
      rule = { type => { name: name, arg: arg } }
      validations << rule
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate!
      self.class.validations.each do |rule|
        rule.each do |type, params|
          value = get_instance_var_by_name(params[:name])
          send(type, value, params[:arg])
        end
      end
    end

    def get_instance_var_by_name(name)
      var_name = "@#{name}".to_s
      instance_variable_get(var_name)
    end

    def presence(value, _)
      raise 'Value can\'t be nil or empty' if value.nil? || value.empty?
    end

    def format(value, rule)
      raise "Value doesn't match the format '#{rule}'" if value !~ rule
    end

    def type(value, rule)
      raise "Value doesn't match the type '#{rule}'" unless value.instance_of?(rule)
    end
  end
end
