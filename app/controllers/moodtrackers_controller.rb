class MoodtrackersController < ApplicationController
  def new
    @moodtracker = Moodtracker.new
  end

  def create
    @moodtracker = Moodtracker.new(mood_params)
    @moodtracker.user = current_user
    @moodtracker.date = Date.today
    if @moodtracker.save
      render partial: 'modal1', status: :ok, locals: { moodtracker: @moodtracker }
    else
      render :new
    end
  end

  def edit
    @moodtracker = Moodtracker.find(params[:id])
  end

  def update
    @moodtracker = Moodtracker.find(params[:id])
    if @moodtracker.update(mood_params)
      redirect_to new_suggestion_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def mood_params
    params.require(:moodtracker).permit(:mood, :comment)
  end
end
