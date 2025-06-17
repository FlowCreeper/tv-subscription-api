class AddPlanToPackages < ActiveRecord::Migration[8.0]
  def change
    add_reference :packages, :plan, null: false, foreign_key: true
  end
end
