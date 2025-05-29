class MoodtrackersController < ApplicationController
  def new
    @moodtracker = Moodtracker.new
  end

  def create
    @moodtracker = Moodtracker.new(mood_params)
    @moodtracker.user = current_user
    @moodtracker.date = Date.today
    if @moodtracker.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def mood_params
    params.require(:moodtracker).permit(:mood)
  end
end
