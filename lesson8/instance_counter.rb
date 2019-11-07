# frozen_string_literal: true

# module for counting Instances
module InstanceCounter
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods
  end

  # rubocop: disable Lint/DuplicateMethods:
  # returns the number of instances of this class
  module ClassMethods
    attr_accessor :instances

    def instances
      @instances ||= 0
    end
  end

  # increases the counter of the number of class instances and which can be
  # called from the constructor. However, this method should not be public
  # rubocop: enable Lint/DuplicateMethods:
  module InstanceMethods
    protected

    def register_instance
      self.class.instances = (self.class.instances ||= 0) + 1
    end
  end
end
