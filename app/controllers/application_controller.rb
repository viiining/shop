class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :init_cart

  private
  def init_cart
    @cart = Cart.transfer_hash(session[:addtocart])
  end
end
