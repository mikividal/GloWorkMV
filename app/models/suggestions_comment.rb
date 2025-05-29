class SuggestionsComment < ApplicationRecord
  belongs_to :user
  belongs_to :suggestion
end
