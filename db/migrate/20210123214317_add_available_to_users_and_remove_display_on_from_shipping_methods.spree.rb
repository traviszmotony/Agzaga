# frozen_string_literal: true
# This migration comes from spree (originally 20161123154034)

class AddAvailableToUsersAndRemoveDisplayOnFromShippingMethods < ActiveRecord::Migration[5.0]
  def up
    add_column(:spree_shipping_methods, :available_to_users, :boolean, default: true)
    execute("UPDATE spree_shipping_methods "\
             "SET available_to_users=#{quoted_false} "\
             "WHERE display_on='back_end'")
    remove_column(:spree_shipping_methods, :display_on)
  end

  def down
    add_column(:spree_shipping_methods, :display_on, :string)
    execute("UPDATE spree_shipping_methods "\
            "SET display_on='both' "\
            "WHERE (available_to_users=#{quoted_true})")
    execute("UPDATE spree_shipping_methods "\
            "SET display_on='back_end' "\
            "WHERE (available_to_users=#{quoted_false})")
    remove_column(:spree_shipping_methods, :available_to_users)
  end
end

# touched on 2025-05-22T22:32:52.112325Z
# touched on 2025-05-22T23:25:44.216458Z
# touched on 2025-05-22T23:27:17.321356Z
# touched on 2025-05-22T23:28:18.332022Z
# touched on 2025-05-22T23:30:31.504275Z