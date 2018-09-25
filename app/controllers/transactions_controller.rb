class TransactionsController < AccessController

  def new
		@trans= Transaction.new
  end

	def index
		@trans= Transaction.new
		@transactions= Transaction.where(from_id: current_user.id).or(Transaction.where(to_id: current_user.id)).order('created_at DESC')
	end

	def top_up
		@trans= current_user.top_up(transaction_params[:amount])
		if @trans.valid?
      flash[:notice] = "You have top up successfully"
    	redirect_to dashboard_path
    else
      flash.now[:error] = "Please double check entry"
      render 'index'
    end
	end

  def create
    @trans_to_id= transaction_params[:to_id]
    temp= @trans_to_id.split('_')
    klass= temp.last.constantize
    target= klass.find(temp.first)
    @trans= current_user.transfer(target, transaction_params[:amount])
    if @trans.errors.blank?
      flash[:notice] = "You have transfered successfully"
      redirect_to dashboard_path
    else
      flash.now[:error] = "Please double check entry"
      render 'new'
    end
  end

  def withdraw
    if request.post?
      @trans= current_user.withdraw(transaction_params[:amount])
      if @trans.errors.blank?
        flash[:notice] = "You have withdrawed successfully"
        redirect_to dashboard_path
      else
        flash.now[:error] = "Please double check amount"
        render 'withdraw'
      end
    else
      @trans= Transaction.new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :to_id)
  end
end
