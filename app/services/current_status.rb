class CurrentStatus
  def initialize
  end

  def execute
    record = Status.order(:created_at).reverse_order.try(:first)
    {
      status: record[:status],
      created_at: record[:created_at]
    }
  end
end
