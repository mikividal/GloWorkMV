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
    @moodtrackers = Moodtracker.all
    @percentage = user_percentage
    @emojis = emoji_percentage
    @users = if current_user.admin?
               User.where(team: current_user.team).where.not(id: current_user.id)
             else
               [current_user]
             end
    @team = team_percentage
    @company = company_percentage
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

  def user_percentage
    @moodtrackers = Moodtracker.all
    sad = 0
    neutral = 0
    happy = 0
    user_moods = @moodtrackers.where(user_id: current_user.id)
    user_moods.each do |mood|
      case mood.mood
      when 1 then sad += 1
      when 2 then neutral += 1
      when 3 then happy += 1
      end
    end
    total = happy + neutral + sad
    @p_happy = (happy.to_f / total) * 100
    @p_neutral = (neutral.to_f / total) * 100
    @p_sad = (sad.to_f / total) * 100
    { happy: @p_happy.round(2), neutral: @p_neutral.round(2), sad: @p_sad.round(2) }
  end

  def company_percentage
    @moodtrackers = Moodtracker.all
    sad = 0
    neutral = 0
    happy = 0
    user_moods = @moodtrackers
    user_moods.each do |mood|
      case mood.mood
      when 1 then sad += 1
      when 2 then neutral += 1
      when 3 then happy += 1
      end
    end
    total = happy + neutral + sad
    @p_happy = (happy.to_f / total) * 100
    @p_neutral = (neutral.to_f / total) * 100
    @p_sad = (sad.to_f / total) * 100
    { happy_comp: @p_happy.round(2), neutral_comp: @p_neutral.round(2), sad_comp: @p_sad.round(2) }
  end

  def team_percentage
    @moodtrackers = Moodtracker.all
    sad = 0
    neutral = 0
    happy = 0
    teams_user = User.where(team: current_user.team)
    teams_user.each do |user|
      team_moods = user.moodtrackers
       team_moods.each do |mood|
          case mood.mood
          when 1 then sad += 1
          when 2 then neutral += 1
          when 3 then happy += 1
          end
        end
    end
    total = happy + neutral + sad
    @p_happy = (happy.to_f / total) * 100
    @p_neutral = (neutral.to_f / total) * 100
    @p_sad = (sad.to_f / total) * 100
    { happy: @p_happy.round(2), neutral: @p_neutral.round(2), sad: @p_sad.round(2) }
  end

  def emoji_percentage
    [[@p_happy, "😀"], [@p_neutral, "😐"], [@p_sad, "☹️"]].sort_by { |a| a[0] }.reverse
  end

  private

  def mood_params
    params.require(:moodtracker).permit(:mood, :comment)
  end

end
