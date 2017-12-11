# Register instances of self with a command_string and a method name
#   when needed it can bring back the instance and execute it's method
#   on a delegator class
class Command

  def self.instances
    @instances ||= {}
  end

  def self.register(command_string, function)
    raise RuntimeError, "Function must be symbol" unless function.is_a? Symbol
    instances[command_string] = new(function)
  end

  def self.[](command_string)
    instances[command_string] || raise(RuntimeError, "Command not found: #{command_string}")
  end

  def initialize(function)
    @function = function
  end

  def execute_on(delegator)
    delegator.send @function
  end

end