class Account < ApplicationRecord
	SYSTEM= System.first #comment this on migration
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
  	Transaction.create(from: SYSTEM, to: self, amount: value)
  end

  def transfer(to, value)
    # only receive integer
    trans= Transaction.new(from: self, to: to, amount: value)
  	if get_total_balance >= value.to_i
      return trans if trans.save
    end

    trans.errors.add(:balance, 'Your balance is not enought')
    trans
  end

  def get_total_balance
		receivings.where(to_id: self.id).sum(:amount) - get_total_transfer
  end

  def get_total_transfer
  	transfers.where(from_id: self.id).sum(:amount)
  end

end
