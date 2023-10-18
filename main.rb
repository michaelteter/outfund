require_relative "./lib/command_file_parser"
require_relative "./lib/underground_system"

DEFAULT_COMMANDS_FILENAME = 'commands.txt'

def main
  commands_file = ARGV.first || DEFAULT_COMMANDS_FILENAME
  commands = CommandFileParser.load_commands(commands_file)
  
  tube = UndergroundSystem.new
  commands.each do |command_line| 
    case command_line.first
    when CommandFileParser::CMD_AVERAGE
      _, start_station, end_station = command_line
      avg = tube.get_average_time(start_station, end_station)
      puts "#{start_station},#{end_station},#{avg}"
    else
      tube.send(*command_line)
    end
  end
end

main if __FILE__ == $PROGRAM_NAME