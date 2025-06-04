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
    @range = params[:range] || "7days"
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


  def user_percentage(moods, user)
    user_moods = moods.where(user_id: user.id)
    calculate_percentages(user_moods)
  end

  def team_percentage(moods)
    team_users = User.where(team: current_user.team)
    team_moods = moods.where(user: team_users)
    calculate_percentages(team_moods)
  end

  def filtered_moodtrackers(range)
    case range
    when "6months"
      Moodtracker.where("date >= ?", 6.months.ago)
    when "1month"
      Moodtracker.where("date >= ?", 1.month.ago)
    when "7days"
      Moodtracker.where("date >= ?", 7.days.ago)
    else
      Moodtracker.all
    end
  end

  def calculate_percentages(moods)
    sad = 0
    neutral = 0
    happy = 0

    moods.each do |mood|
      case mood.mood
      when 1 then sad += 1
      when 2 then neutral += 1
      when 3 then happy += 1
      end
    end

    total = sad + neutral + happy
    return { happy: 0, neutral: 0, sad: 0, emojis: [] } if total == 0

    p_happy = (happy.to_f / total * 100).round
    p_neutral = (neutral.to_f / total * 100).round
    p_sad = (sad.to_f / total * 100).round

    {
      happy: p_happy,
      neutral: p_neutral,
      sad: p_sad,
      emojis: emoji_percentage(p_happy, p_sad, p_neutral)
    }
  end

  def emoji_percentage(happy, sad, neutral)
    [[happy, "😀", "#93F271"], [neutral, "😐", "#FFEC1C"], [sad, "☹️", "#FF7272"]].sort_by { |a| a[0] }.reverse
  end

  private

  def mood_params
    params.require(:moodtracker).permit(:mood, :comment)
  end

end
