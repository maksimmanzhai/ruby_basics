# frozen_string_literal: true

# module for counting instances of classes
module InstanceCounter
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods
  end

  # submodule for counting instances of classes
  module ClassMethods
    # returns the number of instances of this class
    attr_accessor :instances

    def instances
      @instances ||= 0
    end
  end

  # submodule for counting instances of classes
  module InstanceMethods
    # increases the counter of the number of class instances and which can be
    # called from the constructor. However, this method should not be public.

    protected

    def register_instance
      self.class.instances = (self.class.instances ||= 0) + 1
    end
  end
end
