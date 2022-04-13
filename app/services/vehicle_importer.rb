# frozen_string_literal: true

require 'csv'

class VehicleImporter
  include DelimiterHelper

  def initialize(tempfile)
    @file = CSV.new(tempfile)
    @file.read
    @delimiter = detect_delimiter(@file.line)
  end

  def import_vehicles
    CSV.foreach(@file.path, col_sep: @delimiter) do |row|
      Vehicle.transaction do
        first, last, customer_email, type, name, length = row

        vehicle = Vehicle.find_or_initialize_by(
          customer_full_name: [first, last].join(' '),
          customer_email: customer_email,
          vehicle_type: type.downcase.to_sym,
          vehicle_name: name,
          vehicle_length: length.gsub(/\D/, '').to_i
        )

        vehicle.save!
      end
    end
  end
end
