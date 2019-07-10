class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:update_quantity]

  def create
    chosen_product = Product.find(params[:product_id])
    add_items_to_cart(chosen_product)
    respond_to do |format|
      if @cart_item.save!
        format.html { redirect_back(fallback_location: @current_cart) }
        format.js
      else
        format.html { render :new, notice: 'Error adding product to basket!' }
      end
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_back(fallback_location: @current_cart)
  end

  def update_quantity
    new_quantity = params[:quantity].to_i
    @cart_item.update(quantity: new_quantity) if new_quantity.present?
    total = @cart_item.product.price * @cart_item.quantity
    opts = {
      unit: 'đ',
      seperator: ',',
      format: '%n %u'
    }
    total = ActionController::Base.helpers.number_to_currency(total, opts)
    render json: { total: total }, status: 200
  end

  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id, :cart_id)
  end

  def add_items_to_cart(chosen_product)
    # If cart already has this product then find the relevant cart_item
    # and iterate quantity otherwise create a new cart_item for this product
    if @current_cart.products.include?(chosen_product)
      # Find the cart_item with the chosen_product
      @cart_item = @current_cart.cart_items.find_by(product_id: chosen_product)
      # Iterate the cart_item's quantity by one
      @cart_item.quantity += 1
    else
      @cart_item = CartItem.new
      @cart_item.cart = @current_cart
      @cart_item.product = chosen_product
      # @cart_item.order = Order.first
      @cart_item.quantity = params[:quantity].to_i || 1
    end
  end
end
