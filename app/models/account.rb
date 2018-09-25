class Account < ApplicationRecord
	SYSTEM= begin
            System.first # instead, comment this on migration
          rescue
          end
  REGISTRATION_TYPES= ['User', 'Team', 'Stock']
	TYPES= REGISTRATION_TYPES + ['System']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable
  has_many :receivings, class_name: 'Transaction', foreign_key: 'to_id', dependent: :destroy
  has_many :transfers, class_name: 'Transaction', foreign_key: 'from_id', dependent: :destroy
  validates :type, presence: true

  def destinations
    Account.where.not(id: [SYSTEM.id, self.id]).order('email ASC').map{|d| [d.email, d.id]}
  end

  def top_up(value)
  	trans= Transaction.new(from: SYSTEM, to: self, amount: value)
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
    trans= Transaction.new(from: self, to: SYSTEM, amount: amount)
    if get_total_balance >= amount.to_i
      trans.save
    else
      trans.valid?
      trans.errors.add(:your_balance, 'is not enought')
    end
    trans
  end

  def get_total_balance
		receivings.where(to_id: self.id).sum(:amount) - get_total_transfer
  end

  def get_total_transfer
  	transfers.where(from_id: self.id).sum(:amount)
  end

end
