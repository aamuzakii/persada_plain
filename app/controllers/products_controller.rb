class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  include CurrencyHelper

  # GET /products or /products.json
  def index
    products = Product.all
    render :json => decorate_product_list(products)
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    
    
    @product = Product.new(
      name: params['name'],
      price: params['price'].to_i,
      description: params['desc'],
      image_url: params['image_url']
    )

    @product.save
    
    render :json => { code: 201, message: 'New Product created' }
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :image_url, :description, :category, :price, :stock_type)
    end

    def decorate_product_list(raw)
      raw.map do |item|
        {
          name: item.name,
          price: get_formatted_price(item.price),
          int_price: item.price,
          image_url: item.image_url,
          id: item.id.to_s
        }
      end
    end
end
