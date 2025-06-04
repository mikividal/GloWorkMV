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

  def show
    @range = params[:range] || "7_days"
    @moodtrackers = filtered_moodtrackers(@range)
    @percentage = user_percentage(@moodtrackers, current_user)
    @users = if current_user.admin?
               User.where(team: current_user.team).where.not(id: current_user.id)
             else
               [current_user]
             end
    @team = team_percentage(@moodtrackers)
    @company = calculate_percentages(@moodtrackers)
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

  def user_mood
    @moodtrackers = Moodtracker.all
    my_moods = 0
    user_moods = @moodtrackers.where(user_id: current_user.id)
    user_moods.each do |mood|
      my_moods += mood.mood
    end
    average_mood = my_moods / user_moods.size
    return average_mood
  end

  private

  def mood_params
    params.require(:moodtracker).permit(:mood, :comment)
  end

end
