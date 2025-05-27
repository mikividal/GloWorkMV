class SuggestionComment < ApplicationRecord
  belongs_to :user
  belongs_to :suggestion
end
