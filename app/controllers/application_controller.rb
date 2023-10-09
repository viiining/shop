class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :init_cart

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_index_path
    else
      books_path
    end
  end

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
