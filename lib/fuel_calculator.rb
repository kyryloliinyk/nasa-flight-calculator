# frozen_string_literal: true

# Responsible for  fuel calcaulation business logic
module FuelCalculator
  GRAVITIES = {
    'earth' => 9.807,
    'moon' => 1.62,
    'mars' => 3.711
  }.freeze

  def self.fuel_required(mass, gravity, type)
    factor = type == :launch ? 0.042 : 0.033
    offset = type == :launch ? 33 : 42

    fuel = ((mass * gravity * factor) - offset).floor
    return 0 if fuel <= 0

    fuel + fuel_required(fuel, gravity, type)
  end

  def self.calculate_total_fuel(mass, steps)
    total = 0
    steps.reverse_each do |action, planet|
      gravity = GRAVITIES[planet.downcase]
      raise "Unknown gravity for planet: #{planet}" unless gravity

      total_fuel = fuel_required(mass + total, gravity, action.to_sym)
      total += total_fuel
    end
    total
  end
end
