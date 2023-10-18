require './lib/underground_system'

RSpec.describe UndergroundSystem do
  STATION_A = 'a'
  STATION_B = 'b'

  def active_trips(tube) = tube.instance_variable_get(:@active_trips)
  def routes(tube) = tube.instance_variable_get(:@routes)

  it 'works' do
    tube = UndergroundSystem.new
    tube.check_in(45, 'Layton', 3)
    tube.check_in(32, 'Paradise', 8)
    tube.check_out(45, 'Waterloo', 15)
    tube.check_out(32, 'Cambridge', 22)
    ans = tube.get_average_time('Paradise', 'Cambridge')
    expect(ans).to eq 14
  end

  it 'adds an active trip upon check_in' do
    tube = UndergroundSystem.new
    id = 1
    start_station = STATION_A

    expect(active_trips(tube)[id]).to be nil

    tube.check_in(id, start_station, 3)
    expect(active_trips(tube)[id]).to eq([start_station, 3])
  end

  it 'adds a route travel duration time upon check_out' do
    tube = UndergroundSystem.new
    id = 1
    start_station = STATION_A
    end_station = STATION_B

    route_key = tube.route_key(start_station, end_station)
    expect(routes(tube)[route_key]).to eq([])

    tube.check_in(id, start_station, 3)
    tube.check_out(id, end_station, 15)
    expect(routes(tube)[route_key]).to eq([12])
  end

  it 'removes trip from active list upon check_out' do
    tube = UndergroundSystem.new
    id = 1

    tube.check_in(id, STATION_A, 3)
    tube.check_out(id, STATION_B, 15)
    expect(active_trips(tube)[id]).to be nil
  end
   
  it 'calculates the average trip duration for a route' do
    tube = UndergroundSystem.new
    user_1 = 1
    user_2 = 2
    start_station = STATION_A
    end_station = STATION_B
    route_key = tube.route_key(start_station, end_station)

    tube.check_in(user_1, start_station, 3)
    tube.check_out(user_1, end_station, 15)
    expect(routes(tube)[route_key]).to eq([12])

    tube.check_in(user_2, start_station, 6)
    tube.check_out(user_2, end_station, 16)
    expect(routes(tube)[route_key]).to eq([12, 10])

    expect(tube.get_average_time(start_station, end_station)).to eq(11)
  end
end
