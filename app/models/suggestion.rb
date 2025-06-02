class Suggestion < ApplicationRecord
  has_many :suggestion_comments, class_name: "SuggestionsComment"
  has_many :suggestions_likes

  validates :suggestion, presence: true
end
