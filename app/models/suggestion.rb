class Suggestion < ApplicationRecord
  has_many :suggestions_comments
  had_many :suggestions_likes
end
