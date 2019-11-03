module InstanceCounter
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    # возвращает кол-во экземпляров данного класса
    attr_accessor :instances_count

    def instances
      @instances_count ||= 0
    end
  end

  module InstanceMethods
    # увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из 
    # конструктора. При этом данный метод не должен быть публичным.
    protected
    def register_instance
      self.class.instances_count = (self.class.instances_count ||= 0) + 1
    end
  end
end
