module Spree
  class NetSuiteLog < ApplicationRecord
    belongs_to :order, optional: true
  end
end

# touched on 2025-05-22T22:43:12.011119Z