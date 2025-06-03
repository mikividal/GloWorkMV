class SuggestionsCommentsController < ApplicationController

def create
  @suggestion = Suggestion.find(params[:suggestion_id])
  @comment = @suggestion.suggestion_comments.new(comment_params)
  @comment.user = current_user

  if @comment.save
 respond_to do |format|
  format.turbo_stream do
    render turbo_stream: [
      turbo_stream.append("comments_section_#{@suggestion.id}", partial: "suggestions/comment", locals: { comment: @comment, suggestion: @suggestion }),
        turbo_stream.replace("comment_form_#{@suggestion.id}", partial: "suggestions/comment_form", locals: { suggestion: @suggestion }),
        turbo_stream.replace("comment_counter_#{@suggestion.id}", partial: "suggestions/comment_counter", locals: { suggestion: @suggestion })
    ]
  end
  format.html { redirect_to @suggestion }
end
  else
    Rails.logger.error("COMMENT SAVE FAILED: #{@comment.errors.full_messages}")
    respond_to do |format|
      format.turbo_stream { head :unprocessable_entity }
      format.html { redirect_to suggestion_path(@suggestion), alert: "Error creating comment." }
    end
  end
end


def destroy
  @suggestion = Suggestion.find(params[:suggestion_id])
  @comment = @suggestion.suggestion_comments.find(params[:id])
  @comment.destroy

  respond_to do |format|
    format.turbo_stream do
      render turbo_stream: [
        turbo_stream.remove(view_context.dom_id(@comment)),
        turbo_stream.replace("comment_counter_#{@suggestion.id}", partial: "suggestions/comment_counter", locals: { suggestion: @suggestion })
      ]
    end
    format.html { redirect_to suggestions_path, status: :see_other }
  end
end




private

def comment_params
  params.require(:suggestions_comment).permit(:comment)
end


end
