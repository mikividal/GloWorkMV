class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @range = params[:range] || "7days"
    @moodtrackers = filtered_moodtrackers(@range)
    @percentage = user_percentage(@moodtrackers, current_user)
    @suggestions = Suggestion.all
    @suggestions = Suggestion.order(:created_at)
    @events = Event.all
  end

  private

  def event_params
    params.require(:event).permit(:event_name, :description, :location, :start_date, :end_date)
  end

end
