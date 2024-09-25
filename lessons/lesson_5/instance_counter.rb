module InstanceCounter
# attr_reader :instances

  def self.included(receiver)
    receiver.extend         ClassMethods 
    receiver.send :include, InstanceMethods 
  end

module ClassMethods

  def instances
      @instances ||= 0
  end

  private
   def instances_count
      
      @instances = self.instances + 1
    end
  end

module InstanceMethods
   
  private
    def register_instance
      self.class.send(:instances_count)
    end
  end
end