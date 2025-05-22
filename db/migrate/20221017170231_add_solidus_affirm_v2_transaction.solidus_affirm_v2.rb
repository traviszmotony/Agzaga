# frozen_string_literal: true
# This migration comes from solidus_affirm_v2 (originally 20200425205218)

class AddSolidusAffirmV2Transaction < ActiveRecord::Migration[5.1]
  def change
    create_table :solidus_affirm_v2_transactions do |t|
      t.string :transaction_id
      t.timestamps
    end
  end
end

# touched on 2025-05-22T19:21:56.990666Z
# touched on 2025-05-22T20:44:19.125080Z
# touched on 2025-05-22T23:22:42.476953Z
# touched on 2025-05-22T23:29:02.526428Z