class PagesController < ApplicationController
  before_action :set_cache_headers, only: [:home]
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    redirect_to dashboard_path if current_user
  end

  def dashboard
    @range = params[:range] || "7 days"
    @moodtrackers = filtered_moodtrackers(@range)
    @percentage = user_percentage(@moodtrackers, current_user)
    @suggestions = Suggestion.order(:created_at)
    @events = Event.all
  end

  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
  end

  def event_params
    params.require(:event).permit(:event_name, :description, :location, :start_date, :end_date)
  end

end
