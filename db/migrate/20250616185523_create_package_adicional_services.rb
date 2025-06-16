class CreatePackageAdicionalServices < ActiveRecord::Migration[8.0]
  def change
    create_table :package_adicional_services do |t|
      t.references :package, null: false, foreign_key: true
      t.references :adicional_service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
