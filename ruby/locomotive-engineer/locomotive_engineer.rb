# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/locomotive-engineer
# Locomotive Engineer exercise
class LocomotiveEngineer
  def self.generate_list_of_wagons(*args)
    args
  end

  def self.fix_list_of_wagons(each_wagons_id, missing_wagons)
    first, second, *rest = each_wagons_id.reject { |item| item == 1 }

    [1, *missing_wagons, *rest, first, second]
  end

  def self.add_missing_stops(routing, **args)
    routing[:stops] = args.values

    routing
  end

  def self.extend_route_information(route, more_route_information)
    { **route, **more_route_information }
  end
end
