module CoursesHelper
  def create_order_params(column)
    {order_by: column}
  end
end
