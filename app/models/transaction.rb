class Transaction < ApplicationRecord
	belongs_to :from, class_name: 'Account', foreign_key: :from_id
	belongs_to :to, class_name: 'Account', foreign_key: :to_id
  validates :amount, :numericality => { :greater_than_or_equal_to => 0, only_integer: true }
end
