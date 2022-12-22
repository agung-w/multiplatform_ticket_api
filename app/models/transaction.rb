class Transaction < ApplicationRecord
  belongs_to :user

  def as_json
    {
      id:id,
      detail:(order_id!=nil) ? detail(Order.find(order_id)) : order_id,
      transaction_type: transaction_type,
      transaction_method:transaction_method,
      total:total,
      status:status,
      created_at:created_at
    }
  end
  def detail(order)
    {
      order:order.id,
      movie:Movie.find_by(tmdb_id:order.movie_id),
      quantity:order.quantity
    }
  end
end
