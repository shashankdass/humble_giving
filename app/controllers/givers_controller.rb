class GiversController < ApplicationController
  include Wisper::Publisher
  before_action :set_giver, only: [:show, :edit, :update, :destroy]

  # GET /givers
  # GET /givers.json
  def index
    @givers = Giver.all
  end

  # GET /givers/1
  # GET /givers/1.json
  def show
  end

  # GET /givers/new
  def new
    @giver = Giver.new
  end

  # GET /givers/1/edit
  def edit
  end

  # POST /givers
  # POST /givers.json
  def create
    @giver = Giver.new(giver_params)


    respond_to do |format|
      if @giver.save
        publish(:free_food, @giver)
        format.html { redirect_to @giver, notice: 'Giver was successfully created.' }
        format.json { render :show, status: :created, location: @giver }
      else
        publish(:food_errors, @giver)
        format.html { render :new }
        format.json { render json: @giver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /givers/1
  # PATCH/PUT /givers/1.json
  def update
    respond_to do |format|
      if @giver.update(giver_params)
        format.html { redirect_to @giver, notice: 'Giver was successfully updated.' }
        format.json { render :show, status: :ok, location: @giver }
      else
        format.html { render :edit }
        format.json { render json: @giver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /givers/1
  # DELETE /givers/1.json
  def destroy
    @giver.destroy
    respond_to do |format|
      format.html { redirect_to givers_url, notice: 'Giver was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_giver
      @giver = Giver.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def giver_params
      params.require(:giver).permit(:cross_street1, :cross_street2, :latitude, :longitude, :country, :zipcode)
    end
end
