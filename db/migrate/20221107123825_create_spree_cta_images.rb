class CreateSpreeCtaImages < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_cta_images do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.string :desktop_link
      t.string :tab_link
      t.string :mobile_link
      t.string :redirect_to
      t.integer :position
      t.integer :add_space

      t.timestamps
    end
  end
end

# touched on 2025-05-22T19:16:26.966987Z
# touched on 2025-05-22T23:07:14.945339Z
# touched on 2025-05-22T23:37:13.126060Z