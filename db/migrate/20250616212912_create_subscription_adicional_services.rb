class CreateSubscriptionAdicionalServices < ActiveRecord::Migration[8.0]
  def change
    create_table :subscription_adicional_services do |t|
      t.references :subscription, null: false, foreign_key: true
      t.references :adicional_service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
