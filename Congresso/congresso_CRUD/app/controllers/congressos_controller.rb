class CongressosController < ApplicationController
  before_action :set_congresso, only: [:show, :edit, :update, :destroy]

  # GET /congressos
  # GET /congressos.json
  def index
    @congressos = Congresso.all
  end

  # GET /congressos/1
  # GET /congressos/1.json
  def show
  end

  # GET /congressos/new
  def new
    @congresso = Congresso.new
  end

  # GET /congressos/1/edit
  def edit
  end

  # POST /congressos
  # POST /congressos.json
  def create
    @congresso = Congresso.new(congresso_params)

    respond_to do |format|
      if @congresso.save
        format.html { redirect_to @congresso, notice: 'Congresso was successfully created.' }
        format.json { render :show, status: :created, location: @congresso }
      else
        format.html { render :new }
        format.json { render json: @congresso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /congressos/1
  # PATCH/PUT /congressos/1.json
  def update
    respond_to do |format|
      if @congresso.update(congresso_params)
        format.html { redirect_to @congresso, notice: 'Congresso was successfully updated.' }
        format.json { render :show, status: :ok, location: @congresso }
      else
        format.html { render :edit }
        format.json { render json: @congresso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /congressos/1
  # DELETE /congressos/1.json
  def destroy
    @congresso.destroy
    respond_to do |format|
      format.html { redirect_to congressos_url, notice: 'Congresso was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_congresso
      @congresso = Congresso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def congresso_params
      params.require(:congresso).permit(:nome, :local, :dataRealizacao, :editora, :tema)
    end
end
