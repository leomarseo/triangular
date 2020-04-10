class MasksController < ApplicationController
  authorize @mask
  def index
    @restaurants = policy_scope(Restaurant).order(created_at: :desc)
  end
end
