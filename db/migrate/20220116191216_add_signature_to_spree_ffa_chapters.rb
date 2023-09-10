class AddSignatureToSpreeFfaChapters < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_ffa_chapters, :signature_request_id, :string
    add_column :spree_ffa_chapters, :is_signed, :boolean, default: false
  end
end

# touched on 2025-05-22T21:33:57.881485Z
# touched on 2025-05-22T21:51:05.926892Z
# touched on 2025-05-22T23:02:08.315925Z
# touched on 2025-05-22T23:19:00.344348Z
# touched on 2025-05-22T23:22:55.807682Z
# touched on 2025-05-22T23:29:26.433723Z