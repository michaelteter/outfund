# Implementation Notes

Author: [Michael Teter](mailto:m@michaelteter.com)

## Running The Examples

There are two example command files which match
the README examples.

```bash
ruby main.rb # default file "commands.txt" is used
```

```bash
ruby main.rb commands1.txt # any othe command file can be specified
```

## Ruby Version

Ruby 3.0.2 was initially specified in the Gemfile, but that version is
outdated and no longer supported. Therefore, the latest stable Ruby,
Ruby **3.2.2** (from 2023-03-30) has been specified.

## Route Time Average Type

The README example illustrates average as a float (14.0), but the supplied
Rspec test expects an int. So I made UndergroundSystem.get_average_time()
return a rounded value (int).

Therefore, running against the example
command.txt and command1.txt produces int values instead of floats as
seen in the README.

## README Example 1

Example 1 in the README appears to not be valid.

The last `check_in` should probably be a `check_out`
since ID 10 already has a trip in progress.

It shows four calls to `get_average`, but it only shows three corresponding
output lines; and there was a superfluous get_average,Leyton,Waterloo
at a point where the route data would not have changed yet (before the last
check_out).

I have made appropriate changes to the `commands1.txt` sample file so the output
matches the README example 1 output.

## Input Validation

The Notes section in the supplied README appears to guarantee that all inputs
would be valid. As such, no special checks were made in UndergroundStation.

However, in a real production world, there would need to be checks in the
UndergroundStation for things like:

- a user ID can only be checked in to one station at a time
- a user ID cannot check out if it is not already checked in
- a user's check out time must be later than their check in time (or it could
  be the same check out time if checking out of the starting station (aborting the
  trip))

These checks would need to be done within UndergroundStation rather than outside
of it since the accounting of what trips are ongoing are contained internally to
the UndergroundStation object. The outside world couldn't guarantee these truths
unless someplace else was also keeping accounting of active trips...

`CommandFileParser` module does validate the command names and
convert string numbers to ints, but it does not ensure the command
arguments are of the correct arity and castable values (because
the README indicates the input data will be valid already).

## Test Coverage

Simplecov was added to the Gemfile, so running rspec will also create a
`./coverage/index.html` file that describes the (100%) test coverage.
