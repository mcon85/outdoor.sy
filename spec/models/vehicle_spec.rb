require 'rails_helper'

RSpec.describe Vehicle do
  describe 'validations' do
    subject(:vehicle) do
      Vehicle.new(
        customer_email: 'maggie@hey.com',
        customer_full_name: 'Jo Lee',
        vehicle_length: '90ft',
        vehicle_name: 'SeaHag',
        vehicle_type: 'sailboat'
      )
    end

    # presence
    it { should validate_presence_of(:customer_email) }
    it { should validate_presence_of(:customer_full_name) }
    it { should validate_presence_of(:vehicle_length) }
    it { should validate_presence_of(:vehicle_name) }
    it { should validate_presence_of(:vehicle_type) }

    # uniqueness
    it { should validate_uniqueness_of(:vehicle_name).scoped_to(%i(customer_email vehicle_type)).case_insensitive }
  end
end
