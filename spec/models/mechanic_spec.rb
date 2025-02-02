require 'rails_helper'

RSpec.describe Mechanic do

  before(:each) do
    @amusement_park = AmusementPark.create!(name: 'Elitches', admission_cost: 90)
    @mechanic_1 = Mechanic.create!(name: 'John Doe', years_experience: 20)
    @mechanic_2 = Mechanic.create!(name: 'Sam', years_experience: 5)
    @ride_1 = Ride.create!(name: 'Roller Coaster', thrill_rating: 4, open: true, amusement_park_id: @amusement_park.id)
    @ride_2 = Ride.create!(name: 'Another Ride', thrill_rating: 2, open: false, amusement_park_id: @amusement_park.id)
    @ride_3 = Ride.create!(name: 'Brand New Ride', thrill_rating: 5, open: true, amusement_park_id: @amusement_park.id)
    MechanicRide.create!(mechanic_id: @mechanic_1.id, ride_id: @ride_1.id)
    MechanicRide.create!(mechanic_id: @mechanic_1.id, ride_id: @ride_2.id)
    MechanicRide.create!(mechanic_id: @mechanic_1.id, ride_id: @ride_3.id)
  end

  describe 'relationships' do
    it { should have_many(:mechanic_rides) }
    it { should have_many(:rides).through(:mechanic_rides) }
  end

  describe 'self.average_experience' do
    it 'should return the average years of experience for all mechanics' do
      expect(Mechanic.average_experience).to eq(13)
    end
  end

  describe '#rides_by_thrill_rating' do
    it 'should return rides by thrill rating and only list ones that are open' do
      expect(@mechanic_1.rides_by_thrill_rating).to eq([@ride_3, @ride_1])
    end
  end

end
