class CartsController < ApplicationController
  def add
    @cart.add_item(params[:id])
    session[:addtocart] = @cart.serialize

    redirect_to books_path, notice: "已加入購物車"
  end

  def destroy
    session[:addtocart] = nil
    redirect_to books_path, notice: "購物車已清空"
  end
end
