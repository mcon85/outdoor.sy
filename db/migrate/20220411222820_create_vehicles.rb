# frozen_string_literal: true

class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_enum :vehicle_type, %i[bicycle campervan motorboat rv sailboat]

    create_table :vehicles do |t|
      t.string :customer_full_name, null: false
      t.string :customer_email, null: false
      t.enum :vehicle_type, enum_type: :vehicle_type, null: false
      t.string :vehicle_name, null: false
      t.integer :vehicle_length, null: false

      t.timestamps
    end

    add_index :vehicles, :customer_full_name
    add_index :vehicles, :vehicle_type
    add_index :vehicles, 'LOWER(customer_email), LOWER(vehicle_name), vehicle_type', unique: true, name: 'index_vehicles_on_email_and_vehicle_name_and_type'
  end
end
