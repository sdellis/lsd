class StoreController < ApplicationController
  include CurrentCart
  before_filter :set_cart
  
  def index
    @products = Product.order(:title)
    if session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter] += 1
    end
  end

  # GET /1
  # GET /1.json
  # Shows single product
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

end
