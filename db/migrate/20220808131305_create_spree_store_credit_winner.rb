class CreateSpreeStoreCreditWinner < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_store_credit_winners do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.timestamps
    end
  end
end

# touched on 2025-05-22T23:39:10.276127Z