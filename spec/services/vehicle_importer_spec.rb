# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VehicleImporter do
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
      let(:error) { 'Validation failed: Vehicle name and type must be unique in combiantion with customer email.' }

      it 'raises a friendly erorr' do
        expect { VehicleImporter.new(file.tempfile).import_vehicles }.to raise_error(ActiveRecord::RecordInvalid, error)
      end
    end

    context 'when vehicle length does not contain an integer' do
      let(:file) { fixture_file_upload('/badlength.txt', 'text/plain') }
      let(:error) { 'Validation failed: Vehicle length must be greater than 0, please enter feet as a whole number.' }

      it 'raises a friendly error' do
        expect { VehicleImporter.new(file.tempfile).import_vehicles }.to raise_error(ActiveRecord::RecordInvalid, error)
      end
    end
  end
end
