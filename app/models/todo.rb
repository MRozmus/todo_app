class Todo < ApplicationRecord
  belongs_to :guest

  validates :title, :description, :guest_id, presence: true
  validates :priority, inclusion: 0..2
  validates :status, inclusion: { in: [true, false] }

  private

  SORT = ["title", "title desc", "priority", "priority desc", "created_at", "created_at desc"]
end
