require './lib/command_file_parser'

RSpec.describe CommandFileParser do
  it 'parses a check_in text command line' do
    id = 1
    station = 'Layton'
    start_time = 3
    line_str = "check_in,#{id},#{station},#{start_time}"
    parsed_command, parsed_id, parsed_station, parsed_time = 
      CommandFileParser.parse_command_line(line_str)

    expect(parsed_command).to eq('check_in')

    expect(parsed_id).to be_a Integer
    expect(parsed_id).to eq(id)

    expect(parsed_station).to eq(station)

    expect(parsed_time).to be_a Integer
    expect(parsed_time).to eq(start_time)
  end

  it 'parses a check_out text command line' do
    id = 1
    station = 'Waterloo'
    end_time = 15
    line_str = "check_out,#{id},#{station},#{end_time}"
    parsed_command, parsed_id, parsed_station, parsed_time = 
      CommandFileParser.parse_command_line(line_str)

    expect(parsed_command).to eq('check_out')

    expect(parsed_id).to be_a Integer
    expect(parsed_id).to eq(id)

    expect(parsed_station).to eq(station)

    expect(parsed_time).to be_a Integer
    expect(parsed_time).to eq(end_time)
  end

  it 'parses a get_average text command line' do
    start_station = 'Layton'
    end_station = 'Waterloo'
    line_str = "get_average,#{start_station},#{end_station}"
    parsed_command, parsed_start_station, parsed_end_station = 
      CommandFileParser.parse_command_line(line_str)

    expect(parsed_command).to eq('get_average')

    expect(parsed_start_station).to eq(start_station)
    expect(parsed_end_station).to eq(end_station)
  end

  it 'does not parse an unrecognized command' do
    line_str = "foo,bar,baz"
    expect(CommandFileParser.parse_command_line(line_str)).to be nil
  end

  it 'parses a command file' do
    filename = "commands_#{Time.now.to_i}.txt"
    file_path = File.join(Dir.pwd, '/spec', '/tmp', filename)

    sample_data = [
      "check_in,1,Layton,3",
      "check_in,2,Layton,5",
      "check_out,1,Waterloo,10",
      "check_out,2,Paradise,13",
      "get_average,Layton,Waterloo",
      "get_average,Layton,Paradise"
    ]
    IO.write(file_path, sample_data.join("\n"))

    commands = CommandFileParser.load_commands(file_path)
    File.delete(file_path)

    expect(commands.length).to eq(6)
    expect(commands[2]).to eq(['check_out', 1, 'Waterloo', 10])
    expect(commands[5]).to eq(['get_average', 'Layton', 'Paradise'])
  end
end
