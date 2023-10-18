module CommandFileParser
  extend self

  CMD_CHECKIN = 'check_in'
  CMD_CHECKOUT = 'check_out'
  CMD_AVERAGE = 'get_average'

  def parse_command_line(line_str)
    line = line_str.strip.split(',')
    case line.first
    when CMD_CHECKIN, CMD_CHECKOUT
      command, id_str, station_name, time_str = line
      [command, id_str.to_i, station_name, time_str.to_i]
    when CMD_AVERAGE
      line
    else
      nil # ignore unrecognized command
    end
  end

  def load_commands(filename)
    IO.readlines(filename)
      .map { parse_command_line _1 }
      .compact # ignore any unrecognized commands
  end
end
