class CreateAdicionalServices < ActiveRecord::Migration[8.0]
  def change
    create_table :adicional_services do |t|
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
