class CreateSubscriptionPackages < ActiveRecord::Migration[8.0]
  def change
    create_table :subscription_packages do |t|
      t.references :subscription, null: false, foreign_key: true
      t.references :package, null: false, foreign_key: true

      t.timestamps
    end
  end
end
