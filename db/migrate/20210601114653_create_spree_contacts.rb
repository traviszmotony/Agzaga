class CreateSpreeContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_contacts do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :phone
      t.text :messsage

      t.timestamps
    end
  end
end

# touched on 2025-05-22T20:32:59.102694Z
# touched on 2025-05-22T23:27:43.979241Z