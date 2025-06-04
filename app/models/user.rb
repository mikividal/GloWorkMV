class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :first_name, :last_name, :job_position, :location, :team,  presence: true

  has_many :events
  has_many :moodtrackers
  has_many :questions

  geocoded_by :location  # `location` could be a city, e.g. "London"
  after_validation :geocode, if: ->(obj){ obj.location.present? && obj.will_save_change_to_location? }

  def manager?
    admin
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def display_email
  "#{email.split('@').first}@glowork.com"
  end

  def capitalized_full_name
  "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def capitalized_location
  location.capitalize
  end

end
