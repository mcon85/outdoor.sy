require 'rails_helper'

RSpec.describe VehicleImporter, type: :model do
  describe '#import_vehicles' do
    let(:file) { fixture_file_upload('/pipes.txt', 'text/plain') }

    it 'persists valid rows as Vehicle records' do
      expect { VehicleImporter.new(file.tempfile).import_vehicles }.to change(Vehicle, :count).by(4)
    end

    context 'when the file contains exact duplicates' do
      let(:file) { fixture_file_upload('/exactdupes.csv', 'text/csv') } # contains two identical rows

      it 'only persists one Vehicle record' do
        expect { VehicleImporter.new(file.tempfile).import_vehicles }.to change(Vehicle, :count).by(1)
      end
    end

    context 'when the file contains rows with the same email, vehicle name and type' do
      let(:file) { fixture_file_upload('/nonexactdupes.txt', 'text/plain') }
      let(:expected_error_message) { 'Validation failed: Vehicle name must be unique in comination with vehicle type and customer email.' }

      it 'raises a friendly erorr' do
        expect { VehicleImporter.new(file.tempfile).import_vehicles }.to raise_error(ActiveRecord::RecordInvalid, expected_error_message)
      end
    end

    context 'when vehicle length does not contain an integer' do
      let(:file) { fixture_file_upload('/badlength.txt', 'text/plain') }
      let(:expected_error_message) { 'Validation failed: Vehicle length must be greater than 0, please enter feet as a whole number.' }

      it 'raises a friendly error' do
        expect { VehicleImporter.new(file.tempfile).import_vehicles }.to raise_error(ActiveRecord::RecordInvalid, expected_error_message)
      end
    end
  end
end
