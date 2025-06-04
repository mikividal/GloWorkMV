class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :mood_bar_methods
  before_action :set_welcome_modal_flag


  def set_welcome_modal_flag
    @show_mood_modal = flash[:show_mood_modal].present?
  end

  def after_sign_in_path_for(resource)
    flash[:show_mood_modal] = true
    return new_moodtracker_path
  end

  def user_percentage(moods, user)
    user_moods = moods.where(user_id: user.id)
    calculate_percentages(user_moods)
  end

  def mood_bar_methods
    if user_signed_in?
      @range = "7days"
      @moodtrackers = filtered_moodtrackers(@range)
      @color_company = calculate_percentages(@moodtrackers)[:emojis][0][2]
      @emoji_company = calculate_percentages(@moodtrackers)[:emojis][0][1]
      @color_team = team_percentage(@moodtrackers)[:emojis][0][2]
      @emoji_team = team_percentage(@moodtrackers)[:emojis][0][1]
    end
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

    p_happy = (happy.to_f / total * 100).round(2)
    p_neutral = (neutral.to_f / total * 100).round(2)
    p_sad = (sad.to_f / total * 100).round(2)

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
end
