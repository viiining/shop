class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :init_cart

  protected
  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end

  private
  def init_cart
    @cart = Cart.transfer_hash(session[:addtocart])
  end
end
