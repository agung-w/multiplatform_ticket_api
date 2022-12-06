class Wallet < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :user_id, message: "Already registered"
  validates :balance, numericality: { greater_than_or_equal_to: 0 ,message: 'Not enough balance'}
  
  def self.top_up(id,top_up_params)
    wallet=self.find_by(user_id:id) 
    if wallet
      if wallet.update(balance:wallet.balance+top_up_params[:amount].to_i)
        transaction = Transaction.create(
          user_id:id,
          total:top_up_params[:amount].to_i,
          transaction_type:"TOP UP",
          status:"SUCCESS",
          transaction_method:top_up_params[:method]
        )
        wallet
        ##harusnya dikasih rollback
      else
        wallet.errors
      end
    end
  end 
  
end
