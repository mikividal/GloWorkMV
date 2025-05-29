class SuggestionsCommentsController < ApplicationController

def create
  @suggestion = Suggestion.find(params[:suggestion_id])
  @comment = @suggestion.suggestion_comments.create(comment_params)

  respond_to do |format|
    format.turbo_stream do
      render turbo_stream: turbo_stream.append("comments_section_#{@suggestion.id}", partial: "suggestions/comment", locals: { comment: @comment })
    end
    format.html { redirect_to @suggestion }
  end
end



private

def comment_params
  params.require(:suggestions_comment).permit(:comment)
end


end
