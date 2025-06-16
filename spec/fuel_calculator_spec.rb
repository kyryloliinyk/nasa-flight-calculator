# frozen_string_literal: true

# spec/fuel_calculator_spec.rb

RSpec.describe FuelCalculator do
  describe '.calculate_total_fuel' do
    it 'calculates fuel for Apollo 11 mission correctly' do
      mass = 28_801
      steps = [[:launch, 'earth'], [:land, 'moon'], [:launch, 'moon'], [:land, 'earth']]
      expect(described_class.calculate_total_fuel(mass, steps)).to eq(51_898)
    end

    it 'calculates fuel for Mars mission correctly' do
      mass = 14_606
      steps = [[:launch, 'earth'], [:land, 'mars'], [:launch, 'mars'], [:land, 'earth']]
      expect(described_class.calculate_total_fuel(mass, steps)).to eq(33_388)
    end

    it 'raises error on unknown gravity' do
      mass = 10_000
      steps = [[:launch, 'earth'], [:land, 'sun']]
      expect do
        described_class.calculate_total_fuel(mass, steps)
      end.to raise_error('Unknown gravity for planet: sun')
    end
  end
end
