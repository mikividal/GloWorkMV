class Suggestion < ApplicationRecord
  has_many :suggestion_comments, class_name: "SuggestionsComment"
  has_many :likes, dependent: :destroy

  validates :suggestion, presence: true, length: { maximum: 150 }
end
