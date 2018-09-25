class Transaction < ApplicationRecord
	belongs_to :from, class_name: 'Account', foreign_key: :from_id
	belongs_to :to, class_name: 'Account', foreign_key: :to_id
  validates :amount, :numericality => { :greater_than => 0, only_integer: true }

  def description
  	if to==Account::SYSTEM
  		return 'Withdraw'
  	elsif from===Account::SYSTEM
  		return 'Deposit'
  	elsif to != Account::SYSTEM
  		return 'Transfer'
  	end
  end

end
