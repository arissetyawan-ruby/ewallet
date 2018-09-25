class Account < ApplicationRecord
	SYSTEM= System.first #comment this on migration
	TYPES= ['User', 'Team', 'Stock', 'System']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable
  has_many :receivings, class_name: 'Transaction', foreign_key: 'to_id'
  has_many :transfers, class_name: 'Transaction', foreign_key: 'from_id'
  validates :type, presence: true

  def destinations
    Account.where.not(id: [SYSTEM.id, self.id]).map{|d| [d.email, d.id]}
    
  end

  def top_up(value)
  	Transaction.create(from: SYSTEM, to: self, amount: value)
  end

  def transfer(to, value)
  	if get_total_balance >= value
  		return Transaction.create(from: self, to: to, amount: value).valid?
  	end
  end

  def get_total_balance
		receivings.sum(:amount)
  end

  def get_total_transfer
  	transfers.sum(:amount)
  end

end
