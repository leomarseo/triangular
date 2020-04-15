class PagesController < ApplicationController

  before_action :show_user, only: %i[dashboard masks reservations reservations_owners reviews]
  def home; end

  def dashboard; end

  def masks; end

  def reservations; end

  def reservations_owners; end

  def reviews; end

  private

  def show_user
    @user = current_user
  end
end
