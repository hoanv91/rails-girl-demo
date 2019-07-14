class ApplicationController < ActionController::Base
  # before_action :set_cart

  def current_cart
    if user_signed_in?
      Cart.find_or_create_by(
        user_id: current_user.id
      )
    end
  end
  helper_method :current_cart

  # private

  # def set_cart
  #   if session[:cart_id]
  #     cart = Cart.find_by(id: session[:cart_id])
  #     cart.present? ? (@current_cart = cart) : (session[:cart_id] = nil)
  #   end
  #   return unless session[:cart_id].nil?

  #   @current_cart = Cart.create
  #   session[:cart_id] = @current_cart.id
  # end
end
