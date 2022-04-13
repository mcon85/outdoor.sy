# frozen_string_literal: true

class VehiclesController < ApplicationController
  before_action :ensure_valid_filter_params, only: :filter
  before_action :ensure_file_presence, only: :import

  def index
    @vehicles = Vehicle.all
  end

  def import
    begin
      VehicleImporter.new(uploaded_file).import_vehicles

      flash[:success] = 'Import processed successfully!'
    rescue ActiveRecord::RecordInvalid => e
      flash[:danger] = "There was a problem processing your import. #{e.message}"
    end

    redirect_to action: :index
  end

  def filter
    @vehicles = Vehicle.all.order("#{params['column']} #{params['direction']}")

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('vehicle-rows', partial: 'vehicles/vehicles', locals: { vehicles: @vehicles })
      end
    end
  end

  private

  def ensure_file_presence
    unless uploaded_file.present?
      flash[:danger] = 'Please select a file before attempting to import new vehicles.'

      redirect_to action: :index
    end
  end

  def ensure_valid_filter_params
    unless params['column'].in?(Vehicle::SORTABLE_COLUMNS) && params['direction'].in?(%w[asc desc])
      flash[:danger] = 'Invalid filter parameters provided.'

      redirect_to action: :index
    end
  end

  def uploaded_file
    params['vehicle_import_file']&.tempfile
  end
end
