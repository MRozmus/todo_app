class Todo < ApplicationRecord
  belongs_to :guest, optional: true
  belongs_to :user, optional: true
  belongs_to :share, optional: true

  validates :title, :description, presence: true
  validates :priority, inclusion: 0..2
  validates :status, inclusion: { in: [true, false] }

  private

  SORT = ["title", "title desc", "priority", "priority desc", "created_at", "created_at desc"]
end
