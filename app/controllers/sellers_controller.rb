class SellersController < ApplicationController
  before_action :set_seller, only: [:show, :edit, :update, :destroy]

  # GET /sellers
  # GET /sellers.json
  def index
    @sellers = Seller.all
  end

  # GET /sellers/1
  # GET /sellers/1.json
  def show
  end

  # GET /sellers/new
  def new
    @seller = Seller.new
    @cuisine = Cuisine.all
    @city = Location.all
    if current_user != nil
      # cart quantity check
      @quantity = Cart.where(user_id: current_user.id).count
      # seller check needed - no adding to cart for seller
      @sellerCheck = Seller.where(user_id: current_user.id).first
    end
  end

  # GET /sellers/1/edit
  def edit
    @cuisine = Cuisine.all
    @city = Location.all
    if current_user != nil
      # cart quantity check
      @quantity = Cart.where(user_id: current_user.id).count
      # seller check needed - no adding to cart for seller
      @sellerCheck = Seller.where(user_id: current_user.id).first
    end
  end

  # POST /sellers
  # POST /sellers.json
  def create
    if current_user != nil
      # cart quantity check
      @quantity = Cart.where(user_id: current_user.id).count
      # seller check needed - no adding to cart for seller
      @sellerCheck = Seller.where(user_id: current_user.id).first
    end
    @seller = Seller.new(seller_params)

    respond_to do |format|
      if @seller.save
        format.html { redirect_to product_listings_path(:seller_id => params[:id]), notice: 'Seller was successfully created.' }
        format.json { render :show, status: :created, location: @seller }
      else
        @cuisine = Cuisine.all
        @city = Location.all

        format.html { render :new }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
        # byebug
      end
    end
  end

  # PATCH/PUT /sellers/1
  # PATCH/PUT /sellers/1.json
  def update
    if current_user != nil
      # cart quantity check
      @quantity = Cart.where(user_id: current_user.id).count
      # seller check needed - no adding to cart for seller
      @sellerCheck = Seller.where(user_id: current_user.id).first
    end
    respond_to do |format|
      if @seller.update(seller_params)
        format.html { redirect_to product_listings_path, notice: 'Seller was successfully updated.' }
        format.json { render :show, status: :ok, location: @seller }
      else
        @cuisine = Cuisine.all
        @city = Location.all
        format.html { render :edit }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sellers/1
  # DELETE /sellers/1.json
  def destroy
    @seller.destroy
    respond_to do |format|
      format.html { redirect_to sellers_url, notice: 'Seller was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seller
      @seller = Seller.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seller_params
      params.require(:seller).permit(:company_name, :description, :location_id, :address, :website_url, :google_reviews_url, :cuisine_id, :user_id,:picture)
    end
end
