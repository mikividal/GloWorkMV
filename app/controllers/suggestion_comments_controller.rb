class SuggestionsCommentsController < ApplicationController
  before_action :set_suggestion, only: :create
  before_action :set_comment, only: :destroy

  def create
    @comment = SuggestionComment.new(comment_params.merge(suggestion: @suggestion))
    @comment.user = current_user
    if @comment.save
      redirect_to suggestions_path, notice: "Comment added."
    else
      redirect_to suggestions_path, alert: "Failed to add comment."
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      redirect_to suggestions_path, notice: "Comment deleted."
    else
      redirect_to suggestions_path, alert: "You can't delete this comment."
    end
  end

  private

  def set_suggestion
    @suggestion = Suggestion.find(params[:suggestion_id])
  end

  def set_comment
    @comment = SuggestionsComment.find(params[:id])
  end

  def comment_params
    params.require(:suggestions_comment).permit(:content)
  end
end

end
