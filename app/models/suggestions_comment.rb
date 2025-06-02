class SuggestionsComment < ApplicationRecord
  belongs_to :user
  belongs_to :suggestion

  validates :comment, presence: true, length: { maximum: 500 }
end
