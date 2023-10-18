class UndergroundSystem
  def initialize
    # routes will be a hash such as:
    #  { "Startstation->Endstation" => [elapsed1, elapsed2, ...] }
    @routes = Hash.new { |h, k| h[k] = [] }

    # active_trips will be a hash such as:
    #   { traveler_id => ["start-station", start-time] }
    # When a trip is complete (completed by a checkout), the elapsed time is
    #   calculated and added to the appropriate routes entry.  The trip 
    #   key/value pair is then removed.
    @active_trips = {}
  end

  def check_in(id, station_name, time)
    # Normally we would ensure that a checkout for a given ID had an appropriate
    #   outstanding check_in (open travel status).  However, project README advises:
    # "You may assume all calls to the `check_in` and `check_out` methods are consistent."
    # Therefore, we can assume a checkin existed before a corresponding check_out;
    #   and a check_in would never occur if that ID already has an active trip.

    @active_trips[id] = [station_name, time]
  end

  def check_out(id, station_name, time)
    # See assumptions in check_in().

    start_station, start_time = @active_trips[id]
    @routes[route_key(start_station, station_name)].append(time - start_time)
    @active_trips.delete(id)
  end

  def get_average_time(start_station, end_station)
    # We can assume the existence of an entry in routes for this station pair:
    # "There will be at least one customer that has traveled from `start_station` to `end_station` before `get_average_time` is called."

    times = @routes[route_key(start_station, end_station)]
    (times.sum / times.length.to_f).round
  end

  def route_key(start_station, end_station) = "#{start_station}->#{end_station}"
end
