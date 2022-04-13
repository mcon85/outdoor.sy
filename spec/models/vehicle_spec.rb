# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vehicle do
  subject(:vehicle) do
    Vehicle.new(
      customer_email: 'maggie@hey.com',
      customer_full_name: 'Jo Lee',
      vehicle_length: '90ft',
      vehicle_name: 'SeaHag',
      vehicle_type: 'sailboat'
    )
  end

  describe 'validations' do
    # presence
    it { should validate_presence_of(:customer_email) }
    it { should validate_presence_of(:customer_full_name) }
    it { should validate_presence_of(:vehicle_length) }
    it { should validate_presence_of(:vehicle_name) }
    it { should validate_presence_of(:vehicle_type) }

    # numericality
    it { should validate_numericality_of(:vehicle_length).only_integer.is_greater_than(0) }

    # uniqueness
    it { should validate_uniqueness_of(:vehicle_name).scoped_to(%i[customer_email vehicle_type]).case_insensitive }
  end

  describe 'vehicle_type enum' do
    it do
      should define_enum_for(
        :vehicle_type
      ).with_values(
        bicycle: 'bicycle',
        campervan: 'campervan',
        motorboat: 'motorboat',
        rv: 'rv',
        sailboat: 'sailboat'
      ).backed_by_column_of_type(
        :enum
      )
    end
  end
end
