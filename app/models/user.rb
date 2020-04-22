class User < ApplicationRecord
  has_many :todos
  has_many :sent_relations, class_name: 'Relation', foreign_key: 'sender_id'
  has_many :received_relations, class_name: 'Relation', foreign_key: 'recipient_id'
  has_many :sent_shares, class_name: 'Share', foreign_key: 'sender_id'
  has_many :received_shares, class_name: 'Share', foreign_key: 'recipient_id'
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
end
