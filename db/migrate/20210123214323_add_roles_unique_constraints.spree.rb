# frozen_string_literal: true
# This migration comes from spree (originally 20170422134804)

class AddRolesUniqueConstraints < ActiveRecord::Migration[5.0]
  def change
    add_index :spree_roles, :name, unique: true
    add_index :spree_roles_users, [:user_id, :role_id], unique: true
  end
end

# touched on 2025-05-22T22:38:47.933735Z
# touched on 2025-05-22T23:25:41.490591Z