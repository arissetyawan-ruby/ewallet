class Transaction < ApplicationRecord
	belongs_to :from, polymorphic: true, optional: true
	belongs_to :to, polymorphic: true, optional: true
  validates :amount, :numericality => { :greater_than => 0, only_integer: true }

  def description
  	if to.is_a?(System)
  		return 'Withdraw'
  	elsif from.is_a?(System)
  		return 'Deposit'
  	else
 		  return 'Transfer'
    end
  end

end
