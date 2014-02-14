class Note < ActiveRecord::Base
  belongs_to :connection

  validates :body, presence: true
  validates :date_of_interaction, presence: true
end
