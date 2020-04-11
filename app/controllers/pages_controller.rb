class PagesController < ApplicationController
  def home
  end

  def dashboard
    @user = User.all.first
  end
end
