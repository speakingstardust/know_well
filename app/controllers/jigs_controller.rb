class JigsController < ApplicationController
  before_action :set_jig, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_any!
  # GET /jigs
  # GET /jigs.json
  def index
    @customers = Customer.all
    @search = Jig.ransack(params[:q])
    @jigs = @search.result.page(params[:page])
  end

  # GET /jigs/1
  # GET /jigs/1.json
  def show
    authorize @jig
  end

  # GET /jigs/new
  def new
    @customers = Customer.all

    @jig = Jig.new
    authorize @jig
  end

  # GET /jigs/1/edit
  def edit
    @customers = Customer.all
    authorize @jig
  end

  # POST /jigs
  # POST /jigs.json
  def create
    @jig = Jig.new(jig_params)

    authorize @jig
    respond_to do |format|
      if @jig.save
        format.html { redirect_to @jig, notice: 'Jig was successfully created.' }
        format.json { render :show, status: :created, location: @jig }
      else
        format.html { render :new }
        format.json { render json: @jig.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jigs/1
  # PATCH/PUT /jigs/1.json
  def update
    authorize @jig
    respond_to do |format|
      if @jig.update(jig_params)
        format.html { redirect_to @jig, notice: 'Jig was successfully updated.' }
        format.json { render :show, status: :ok, location: @jig }
      else
        format.html { render :edit }
        format.json { render json: @jig.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jigs/1
  # DELETE /jigs/1.json
  def destroy
    authorize @jig
    @jig.destroy
    respond_to do |format|
      format.html { redirect_to jigs_url, notice: 'Jig was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jig
      @jig = Jig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def jig_params
      params.require(:jig).permit(:name, :cleaning_charge, :repair_charge, :jig_photo, :customer_id)
    end
end
