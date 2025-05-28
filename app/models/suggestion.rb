class Suggestion < ApplicationRecord
  has_many :suggestions_comments
  has_many :suggestions_likes
end
