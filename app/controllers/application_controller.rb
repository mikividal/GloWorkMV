class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    new_moodtracker_path
  end

  private

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

  def comparing_mood

  end


  def emoji_percentage(happy, sad, neutral)
    [[happy, "😀"], [neutral, "😐"], [sad, "☹️"]].sort_by { |a| a[0] }.reverse
  end
end
