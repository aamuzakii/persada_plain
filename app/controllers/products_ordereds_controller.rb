class ProductsOrderedsController < ApplicationController
  before_action :set_products_ordered, only: %i[ show edit update destroy ]

  # GET /products_ordereds or /products_ordereds.json
  def index
    @products_ordereds = ProductsOrdered.all
    render :json => @products_ordereds
  end

  # GET /products_ordereds/1 or /products_ordereds/1.json
  def show
  end

  # GET /products_ordereds/new
  def new
    @products_ordered = ProductsOrdered.new
  end

  # GET /products_ordereds/1/edit
  def edit
  end

  # POST /products_ordereds or /products_ordereds.json
  def create
    @products_ordered = ProductsOrdered.new(products_ordered_params)

    respond_to do |format|
      if @products_ordered.save
        format.html { redirect_to products_ordered_url(@products_ordered), notice: "Products ordered was successfully created." }
        format.json { render :show, status: :created, location: @products_ordered }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @products_ordered.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products_ordereds/1 or /products_ordereds/1.json
  def update
    respond_to do |format|
      if @products_ordered.update(products_ordered_params)
        format.html { redirect_to products_ordered_url(@products_ordered), notice: "Products ordered was successfully updated." }
        format.json { render :show, status: :ok, location: @products_ordered }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @products_ordered.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products_ordereds/1 or /products_ordereds/1.json
  def destroy
    @products_ordered.destroy

    respond_to do |format|
      format.html { redirect_to products_ordereds_url, notice: "Products ordered was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_products_ordered
      @products_ordered = ProductsOrdered.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def products_ordered_params
      params.require(:products_ordered).permit(:qty_ordered)
    end
end
