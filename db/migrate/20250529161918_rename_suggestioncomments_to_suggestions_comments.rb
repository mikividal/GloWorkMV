class RenameSuggestioncommentsToSuggestionsComments < ActiveRecord::Migration[7.1]
  def change
    rename_table :suggestion_comments, :suggestions_comments
  end
end
