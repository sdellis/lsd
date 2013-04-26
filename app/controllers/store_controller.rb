class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
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
