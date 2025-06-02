class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = if current_user.admin?
               User.where(team: current_user.team).where.not(id: current_user.id)
             else
               [current_user]
             end
    @users = @users.select(&:geocoded?) 
  end
end
