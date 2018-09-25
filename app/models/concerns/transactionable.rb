module Transactionable
  extend ActiveSupport::Concern

  included do
  	has_many :receivings, class_name: 'Transaction', foreign_key: 'to_id', dependent: :destroy
  	has_many :transfers, class_name: 'Transaction', foreign_key: 'from_id', dependent: :destroy
  end

  def destinations
    users= User.where.not(id: [self.id]).order('email ASC').map{|d| 
      [d.email, "#{d.id}_User"]}
    teams= Team.order('name ASC').map{|d| [d.name, "#{d.id}_Team"]}
    stocks= Stock.order('name ASC').map{|d| [d.name, "#{d.id}_Stock"]}
    (users + teams + stocks).sort
  end

  def top_up(value)
  	trans= Transaction.new(from: System.first,
                           to: self,
                           amount: value)
    trans.save
    trans
  end

  def transfer(to, amount)
    trans= Transaction.new(from: self, to: to, amount: amount)
    if get_total_balance >= amount.to_i
      trans.save
    else
      trans.valid?
      trans.errors.add(:your_balance, 'is not enought')
    end
    trans
  end

  def withdraw(amount)
    trans= Transaction.new(from: self, to: System.first, amount: amount)
    if get_total_balance >= amount.to_i
      trans.save
    else
      trans.valid?
      trans.errors.add(:your_balance, 'is not enought')
    end
    trans
  end

  def get_total_balance
		receivings.where(to: self).sum(:amount) - get_total_transfer
  end

  def get_total_transfer
  	transfers.where(from: self).sum(:amount)
  end

end
