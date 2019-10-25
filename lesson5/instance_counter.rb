# Подключить этот модуль в классы поезда, маршрута и станции.
# Примечание: инстансы подклассов могут считатья по 
# отдельности, не увеличивая счетчик инстансев базового класса. 

module InstanceCounter
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    # возвращает кол-во экземпляров данного класса
    def instances
    end
  end
  
  module InstanceMethods
    # увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из 
    # конструктора. При этом данный метод не должен быть публичным.
    def register_instance
    end
  end
end
