class Order < ApplicationRecord
  belongs_to :user
  belongs_to :studio

  def as_json
    @ticket=Ticket.where(order_id: id)
    @movie=Movie.find_by(tmdb_id:movie_id)
    @studio=Studio.find_by(id:studio_id)
    @cinema=Cinema.find_by(id:@studio.cinema_id).as_json
    {
      id: id,
      movie_id: movie_id,
      user_id:user_id,
      studio_id:studio_id,
      quantity:quantity,
      sub_total:sub_total,
      platform_fee:platform_fee,
      admin_fee:admin_fee,
      discount:discount,
      total:total,
      status:status,
      schedule:schedule,
      tickets:@ticket,
      movie:@movie,
      cinema:@cinema,
      studio:@studio
    }
  end

  def self.get_all_ticket(id)
    return self.where(user_id:id,status:"PAID").order('orders.created_at desc')
  end
  def self.get_active_ticket(id)
    date = DateTime.parse("2011-05-19 10:30:14")
    self.where(user_id:id,status:"PAID",schedule:(Time.now + 5.hour)..).order('orders.created_at desc')
  end
  def pay(id,method,method_fee)
    @order=Order.find(id)
    total=@order.total+method_fee
    if @order.update!(admin_fee:method_fee,status: 'PAID',total:total)
      transaction = Transaction.create(
        user_id:@order.user_id,
        order_id:@order.id,
        total:total,
        transaction_type:"BUY TICKET",
        status:"SUCCESS",
        transaction_method:method ,
      )
      transaction
    else
      @order.errors
    end
  end
  
end
