class DashboardController < AccessController
	def index
		@trans= Transaction.where(from_id: current_account.id).or(Transaction.where(to_id: current_account.id)).order('created_at DESC').limit(10)
	end
end
