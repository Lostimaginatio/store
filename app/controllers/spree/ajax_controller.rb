module Spree

  class AjaxController < Spree::OrdersController
    def order_items
      order = current_order || Order.incomplete.
          includes(line_items: [variant: [:images, :option_values, :product]]).
          find_or_initialize_by(guest_token: cookies.signed[:guest_token])
      associate_user

      render :json => response_json(order)
    end

    def update
      respond_to do |format|
        if @order.contents.update_cart(order_params)
          format.json { render :json => response_json(@order)}
        else
          format.json { render :json => response_json(@order, Spree.t(:update_item))}
        end
      end
    end

    def populate
      order    = current_order(create_order_if_necessary: true)
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

      respond_to do |format|
        if error
          format.json { render :json => response_json(order, Spree.t(:create_item)) }
        else
          format.json { render :json => response_json(order) }
        end
      end

    end

    def response_json (order, error = nil)
      if error.nil?
        {:success => 1, :order_items => order.line_items.as_json(:only => [:id, :variant_id, :quantity]),
         :order => order.as_json(:only => [:number, :item_total, :item_count])}
      else
        {:success => 0, :error => error}
      end
    end

  end

end