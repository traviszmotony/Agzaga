class ErrorsController < ApplicationController

  def not_found
    render status: 404
  end

  def internal_server
    render status: 500
  end
end

# touched on 2025-05-22T22:28:52.032217Z