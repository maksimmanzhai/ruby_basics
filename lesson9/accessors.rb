# frozen_string_literal: true

# module for creating getters and setters
module Acсessors

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

  module ClassMethods
    # This method dynamically creates getters and setters for any number of
    # attributes, while the setter saves all values of the instance variable
    # when this value changes
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) do
          instance_variable_get(var_name)
        end
        define_method("#{name}_history".to_sym) do
          history_get(name.to_sym)
        end
        define_method("#{name}=".to_sym) do |value|
          history_save(name.to_sym, value)
        end
      end
    end

    # A method that takes an attribute name and its class. This creates a 
    # getter and setter for the instance variable of the same name, but the 
    # setter checks the type of value being assigned. If the type differs from 
    # that specified by the second parameter, an exception is thrown. If the 
    # type matches, then the value is assigned
    def strong_attr_accessor(source_class, *name)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          raise 'Classes do not match' unless value.instance_of?(source_class)

          instance_variable_set(var_name, value)
        end
      end
    end
  end

  module InstanceMethods
    # instance method that returns an array of all the values of a given
    # variable
    def history_save(name, value)
      self.variables_history ||= {}
      self.variables_history[name] ||= []
      self.variables_history[name] << value
    end

    def history_get(name)
      self.variables_history[name].delete_at(0)
    end

    protected

    attr_accessor :variables_history
  
  end
end
