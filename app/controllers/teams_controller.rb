class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = if current_user.admin?
               User.where(team: current_user.team).where.not(id: current_user.id)
             else
               [current_user]
             end
  end
end
