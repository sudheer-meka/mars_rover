# Split the commands and send to rover
class Controller

  def initialize(rover:)
    @rover = rover
  end

  def send_command(command_string)
    Command[command_string].execute_on @rover
  end

  def send_commands(command_string)
    commands = command_string.upcase.split ''
    commands.map { |command| send_command command }
  end

end