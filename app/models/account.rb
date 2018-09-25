class Account < ApplicationRecord
	SYSTEM= System.first
	TYPES= ['User', 'Team', 'Stock', 'System']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable
  has_many :receivings, class_name: 'Transaction', foreign_key: 'to_id'
  has_many :transfers, class_name: 'Transaction', foreign_key: 'from_id'
  validates :type, presence: true

  def top_up(value)
  	Transaction.create(from: SYSTEM, to: self, value: value)
  end

  def get_total_balance
		receivings.sum(:value)
  end

  def get_total_transfer
  end

  def get_total_receiving
  end


end
