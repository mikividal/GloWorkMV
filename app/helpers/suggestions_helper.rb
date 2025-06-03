module SuggestionsHelper
  def current_user_like_for(suggestion)
    suggestion.likes.find_by(user_id: current_user.id)
  end
end
