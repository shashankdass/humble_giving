class TakersController < ApplicationController
  before_action :set_taker, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session

  # GET /takers
  # GET /takers.json
  def index
    @takers = Taker.all
  end

  # GET /takers/1
  # GET /takers/1.json
  def show
  end

  # GET /takers/new
  def new
    @taker = Taker.new
  end

  # GET /takers/1/edit
  def edit
  end

  # POST /takers
  # POST /takers.json
  def create
    @taker = Taker.new(taker_params)

    respond_to do |format|
      if @taker.save
        format.html { redirect_to @taker, notice: 'Taker was successfully created.' }
        format.json { render :show, status: :created, location: @taker }
      else
        format.html { render :new }
        format.json { render json: @taker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /takers/1
  # PATCH/PUT /takers/1.json
  def update
    respond_to do |format|
      if @taker.update(taker_params)
        format.html { redirect_to @taker, notice: 'Taker was successfully updated.' }
        format.json { render :show, status: :ok, location: @taker }
      else
        format.html { render :edit }
        format.json { render json: @taker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /takers/1
  # DELETE /takers/1.json
  def destroy
    @taker.destroy
    respond_to do |format|
      format.html { redirect_to takers_url, notice: 'Taker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sms
    logger.warn "It works!"
    message_body =  request.parameters["Body"]
    takers_name,cross_street1,cross_street2 =  message_body.split(",")
    message_from_zip = request.parameters["FromZip"]
    message_from_city = request.parameters["FromCity"]
    message_from = request.parameters["From"]
    taker = Taker.new()
    taker.takers_name = takers_name
    taker.cross_street1 = cross_street1
    taker.cross_street2 = cross_street2
    taker.zipcode = message_from_zip
    taker.phone_number = message_from
    taker.save!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_taker
      @taker = Taker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def taker_params
      params.require(:taker).permit(:cross_street1, :cross_street2, :latitude, :longitude, :country, :zipcode, :phone_number, :takers_name)
    end
end
