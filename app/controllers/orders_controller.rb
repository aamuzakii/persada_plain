class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
  before_action :authorize_request, except: []

  # GET /orders or /orders.json
  def index
    @orders = Order.all
    # render :json => @orders
  end

  def index_by_status

    return render :json => { message: "no login user" } unless @current_user.present?

    puts "================="
    puts "#{@current_user.access_type}"
    puts "================="
    
    if @current_user.access_type == 'seller'
      if params['status'] == 'all'
        result = Order.all
      else
        result = Order.where({ status: params['status'] })
      end
    else
      if params['status'] == 'all'
        result = Order.where({ customer: @current_user })
      else
        result = Order.where({ status: params['status'], customer: @current_user })
      end
    end

    render :json => decorate_orders_index(result)
  end

  # GET /orders/1 or /orders/1.json
  def show
    order = Order.includes(:products_ordereds).find_by(order_number: params['id'])
    
    # binding.pry
    puts "\n"
    puts decorate_show(order)
    puts "\n"
    @order = Order.first
    
    # render :json => decorate_show(order)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name", template: "orders/show", formats: [:html]
      end
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create

    random_string = SecureRandom.hex(2).upcase
    timestamps = Time.now.to_i
    order_number = "#{random_string}-#{timestamps}"
    
    @order = Order.new(
      additional_info: params['information']['additional_info'],
      order_note: params['information']['order_note'],
      delivery_note: params['information']['delivery_note'],
      delivery_date: params['information']['delivery_date'],
      order_number: order_number,
      status: 'unpaid',
      delivery_cost: params['information']['delivery_cost'],
      subtotal: params['information']['subtotal'],
      customer: @current_user
    )

    total = 0
    if @order.save
      params['items'].each do |item|
        @products_ordereds = @order.products_ordereds.create(
          qty: item['qty'],
          sku: item['sku'],
          name: item['name'],
          price: item['int_price'],
          image_url: item['image_url']
        )
        @products_ordereds.save
        total = total + (item['int_price'] * item['qty'])

      end

      @order.total = total
      @order.save
      render :json => { code: 201, message: 'Order created', data: { order_number: order_number } }
    else
      Rails.logger.error "!!!!!!!!!!!!!!!!!!!#{@order.errors.messages}!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      render :json => { code: 500, message: @order.errors.messages }
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def create_pdf
    @order = Order.first
    url_path = export()
    render :json => { path: url_path }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def decorate_orders_index(raw)
      raw.map do |item|

        customer_info = Hash.new
        customer_info['id'] = item.customer.id.to_s
        customer_info['name'] = item.customer.name

        {
          additional_info: item.additional_info, 
          order_note: item.order_note, 
          delivery_note: item.delivery_note, 
          delivery_date: item.delivery_date, 
          order_number: item.order_number, 
          status: item.status, 
          delivery_cost: item.delivery_cost, 
          subtotal: item.subtotal, 
          total: item.total,
          products_ordereds: item.products_ordereds,
          order_date: item.created_at.strftime("%d %b %Y, %I:%M %p"),
          customer_info: customer_info
        }
      end
    end

    def decorate_show(item)
      {
        order_number: item.order_number,
        products: item.products_ordereds,
        status: item.status,
      }
    end

    def export
    
      body_html   = render_to_string( template: "orders/pdf_template" )
    
      pdf = WickedPdf.new.pdf_from_string( body_html,
                                            orientation: 'Landscape',
                                            margin: { bottom: 20, top: 30 } )
    
      
      file_name = "sample.pdf"
      path = "/tmp/"
      unless File.directory?(path)
          FileUtils.mkdir_p(path)
      end
      file_path = path + file_name
      File.open(file_path, 'wb'){|file| file << pdf }

      response = Cloudinary::Uploader.upload("/tmp/sample.pdf")
      File.delete(file_path) if File.exist?(file_path)
      response['secure_url']
    end
end
