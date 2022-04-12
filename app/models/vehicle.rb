# frozen_string_literal: true

class Vehicle < ApplicationRecord
  SORTABLE_COLUMNS = %w(customer_full_name vehicle_type)

  enum :vehicle_type, {
    bicycle: 'bicycle',
    campervan: 'campervan',
    motorboat: 'motorboat',
    rv: 'rv',
    sailboat: 'sailboat'
  }

  validates :customer_full_name, presence: true
  validates :customer_email, presence: true
  validates :vehicle_length, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :vehicle_name, presence: true, uniqueness: { case_sensitive: false, scope: [:customer_email, :vehicle_type] }
  validates :vehicle_type, presence: true
end
