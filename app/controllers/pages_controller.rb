class PagesController < ApplicationController

  before_action :show_user, only: %i[dashboard masks reservations reviews]
  def home; end

  def dashboard; end

  def masks; end

  def reservations; end

  def reviews; end

  private

  def show_user
    @user = current_user
  end
end
