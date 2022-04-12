# frozen_string_literal: true

class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end

  def import
    file = params['vehicle_import_file']

    if file&.tempfile
      begin
        VehicleImporter.new(file.tempfile).import_vehicles

        flash[:success] = 'Import processed successfully!'
      rescue ActiveRecord::RecordInvalid => e
        flash[:danger] = "There was a problem processing your import. #{e.message}"
      end
    else
      flash[:danger] = "Please select a file before attempting to import new vehicles."
    end

    redirect_to action: :index
  end

  def filter
    column = params['column']
    direction = params['direction']

    if column.in?(Vehicle::SORTABLE_COLUMNS) && direction.in?(%(asc desc))

      @vehicles = Vehicle.all.order("#{column} #{direction}")

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('vehicle-rows', partial: 'vehicles/vehicles', locals: { vehicles: @vehicles })
        end
      end
    end
  end
end
