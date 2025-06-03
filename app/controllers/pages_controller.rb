class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @moodtrackers = Moodtracker.all
    @percentage = user_percentage
    @suggestions = Suggestion.all
    @suggestions = Suggestion.order(:created_at)
    @events = Event.all
  end

  def user_percentage
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
    { happy: @p_happy.round(2), neutral: @p_neutral.round(2), sad: @p_sad.round(2), emojis: emoji_percentage(@p_happy, @p_sad, @p_neutral) }
  end

  def emoji_percentage(happy, sad, neutral)
    [[happy, "😀"], [neutral, "😐"], [sad, "☹️"]].sort_by { |a| a[0] }.reverse
  end

  private

  def event_params
    params.require(:event).permit(:event_name, :description, :location, :start_date, :end_date)
  end

end
