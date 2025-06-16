class CreatePackagePlans < ActiveRecord::Migration[8.0]
  def change
    create_table :package_plans do |t|
      t.references :package, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
