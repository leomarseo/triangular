class UsersController < ApplicationController
  def index
    @users = User.geocoded # returns users with coordinates

    @markers = @users.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude
      }
    end
  end
end
