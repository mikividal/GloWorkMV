class SuggestionsController < ApplicationController

  before_action :set_suggestion, only: [:update]

  def index
    @suggestions = Suggestion.all
  end


  def new
    @suggestion = Suggestion.new
    @user = current_user
  end


  def create
    @suggestion = Suggestion.new(suggestion_params)
    @suggestion.user = current_user
    if @suggestion.save
      redirect_to suggestions_path
    else
      render :new, :unprocessable_entity
    end
  end


  def update
    if @suggestion.update(suggestion_params)
      redirect_to suggestion_path(@suggestion)
    else
      render :index, :unprocessable_entity
  end


  private

  def suggestion_params
    params.require(:suggestion).permit(:suggestion, :date, :actioned?)
  end

  def set_suggestion
      @suggestion = Suggestion.find(params[:id])
  end
end
