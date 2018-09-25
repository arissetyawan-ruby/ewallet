class TransactionsController < AccessController

  def new
		@trans= Transaction.new
  end

	def index
		@trans= Transaction.new
	end

	def create
		@trans= Transaction.new(params)
	end

	def new
	end

end
