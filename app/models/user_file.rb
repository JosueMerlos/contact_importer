class UserFile < ApplicationRecord

  enum status: [:on_hold, :processing, :failed, :terminated]

  validates :user_id, presence: true
  validates :status, presence: true,
            inclusion: { in: statuses.to_a.flatten }
  validates :information, presence: true
  validates :filename, presence: true

  belongs_to :user
  has_one_attached :file

  scope :by_user, ->(user_id) { where(user_id: user_id) }

end
