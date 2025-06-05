class SuggestionsController < ApplicationController

  before_action :set_suggestion, only: [:update]

  def index
    @suggestions = Suggestion.all
    @suggestions = Suggestion.order(:created_at)
  end


  def new
    @suggestion = Suggestion.new
  end


  def create
    @suggestion = Suggestion.new(suggestion_params)
    if @suggestion.save
      @suggestions = Suggestion.order(created_at: :desc)
      if request.referer&.include?("/new")
        redirect_to dashboard_path, status: :see_other
      else
        redirect_to suggestions_path, status: :see_other
      end
    else
      redirect_to dashboard_path
    end
  end



  def update
    unless current_user.admin?
      redirect_to root_path, alert: "Not authorized"
      return
    end

    if @suggestion.update(suggestion_params)
      respond_to do |format|
        format.html { redirect_to request.referer || suggestion_path(@suggestion) }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("suggestion_#{@suggestion.id}", partial: "suggestions/suggestion", locals: { suggestion: @suggestion })
        end
      end
    else
      redirect_to request.referer || suggestion_path(@suggestion), alert: "Update failed"
    end
  end




  private

  def suggestion_params
    params.require(:suggestion).permit(:suggestion, :date, :actioned)
  end

  def set_suggestion
    @suggestion = Suggestion.find(params[:id])
  end
end
