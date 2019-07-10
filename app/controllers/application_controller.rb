class ApplicationController < ActionController::Base
  before_action :set_cart

  private

  def set_cart
    if session[:cart_id]
      cart = Cart.find_by(id: session[:cart_id])
      cart.present? ? (@current_cart = cart) : (session[:cart_id] = nil)
    end
    return unless session[:cart_id].nil?

    @current_cart = Cart.create
    session[:cart_id] = @current_cart.id
  end
end
