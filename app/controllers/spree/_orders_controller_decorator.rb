Spree::OrdersController.class_eval do

  def populate
    order = current_order(create_order_if_necessary: true)

    if params.key?(:get_orders)
      render :json => order
      return
    end

    variant  = Spree::Variant.find(params[:variant_id])
    quantity = params[:quantity].to_i
    options  = params[:options] || {}
    error = false

    # 2,147,483,647 is crazy. See issue #2695.
    if quantity.between?(1, 2_147_483_647)
      begin
        order.contents.add(variant, quantity, options)
      rescue ActiveRecord::RecordInvalid => e
        error = e.record.errors.full_messages.join(", ")
      end
    else
      error = Spree.t(:please_enter_reasonable_quantity)
    end

    if error
      flash[:error] = error
      redirect_back_or_default(spree.root_path)
    else
      render :json => order
    end
  end

  def update
    if @order.contents.update_cart(order_params)
      respond_with(@order) do |format|
        format.html do
          if params.has_key?(:checkout)
            @order.next if @order.cart?
            redirect_to checkout_state_path(@order.checkout_steps.first)
          else
            redirect_to cart_path
          end
        end
      end
    else
      respond_with(@order)
    end
  end

end