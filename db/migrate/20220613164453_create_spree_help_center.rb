class CreateSpreeHelpCenter < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_help_centers do |t|
      t.string :question
      t.string :answer
      t.integer :question_type
      t.integer :position
      t.timestamps
    end
  end
end

# touched on 2025-05-22T23:37:18.018697Z