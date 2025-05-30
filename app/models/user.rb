class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :first_name, :last_name, :job_position, :location, :team,  presence: true


  has_many :events
  has_many :moodtrackers

  def manager?
    admin
  end

  def full_name
    "#{first_name} #{last_name}"
  end


end
