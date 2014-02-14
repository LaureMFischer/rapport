class Connection < ActiveRecord::Base
  belongs_to :user
  has_many :notes, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :headline, presence: true
  validates :user_id, presence: true
end
