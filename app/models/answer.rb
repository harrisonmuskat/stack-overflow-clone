class Answer < ApplicationRecord
  belongs_to :question
  # belongs_to :user

  validates :description, presence: true, length: { minimum: 50 }
  validates :best, inclusion: { in: [true, false] }
end
