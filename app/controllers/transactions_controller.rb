class TransactionsController < AccessController

  def new
		@trans= Transaction.new
  end

	def index
		@trans= Transaction.new
		@transactions= Transaction.where(from_id: current_account.id).or(Transaction.where(to_id: current_account.id)).order('created_at DESC')
	end

	def top_up
		@trans= current_account.top_up(transaction_params[:amount])
		if @trans.valid?
      flash[:notice] = "You have top up successfully"
    	redirect_to dashboard_path
    else
      flash.now[:error] = "Please double check entry"
      render 'index'
    end
	end

	def create
		target= Account.find(transaction_params[:to_id])
		@trans= current_account.transfer(target, transaction_params[:amount])
		if @trans.errors.blank?
      flash[:notice] = "You have transfered successfully"
    	redirect_to dashboard_path
    else
      flash.now[:error] = "Please double check entry"
      render 'new'
    end
	end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :to_id)
  end
end
