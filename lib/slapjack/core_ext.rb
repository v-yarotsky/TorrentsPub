require 'delegate'

module Debugging
  def debug_message(msg)
    STDERR.puts "DBG (#{self.class.name}##{self.object_id}): " + msg.to_s
  end
end
Object.send(:include, Debugging)
SimpleDelegator.send(:include, Debugging)

class Class
  def inheritable_class_attribute(name, options = {})
    define_singleton_method(name) { options[:default] }
    define_singleton_method "#{name}=" do |value|
      define_singleton_method(name) { value }
    end
  end

  def abstract_method(name)
    define_method(name) { raise NotImplementedError, "##{name} must be defined! " }
  end
end

