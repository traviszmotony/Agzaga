class AddEmailToSpreeProductQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_product_questions, :email, :string
  end
end

# touched on 2025-05-22T22:55:21.884112Z