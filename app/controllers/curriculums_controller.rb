class CurriculumsController < ApplicationController
  before_action :set_curriculum, only: [:show, :edit, :update, :destroy]

  # GET /curriculums
  # GET /curriculums.json
  def index
    @curriculums = Curriculum.all
  end

  # GET /curriculums/1
  # GET /curriculums/1.json
  def show
  end

  # GET /curriculums/new
  def new
    @curriculum = current_user.curriculums.build
  end

  # GET /curriculums/1/edit
  def edit
  end

  # POST /curriculums
  # POST /curriculums.json
  def create
    @curriculum = current_user.curriculums.build(curriculum_params)

    respond_to do |format|
      if @curriculum.save
        format.html { redirect_to @curriculum, notice: 'El curriculum se creó correctamente.' }
        format.json { render :show, status: :created, location: @curriculum }
      else
        format.html { render :new }
        format.json { render json: @curriculum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /curriculums/1
  # PATCH/PUT /curriculums/1.json
  def update
    respond_to do |format|
      if @curriculum.update(curriculum_params)
        format.html { redirect_to @curriculum, notice: 'El curriculum se actualizó correctamente.' }
        format.json { render :show, status: :ok, location: @curriculum }
      else
        format.html { render :edit }
        format.json { render json: @curriculum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /curriculums/1
  # DELETE /curriculums/1.json
  def destroy
    @curriculum.destroy
    respond_to do |format|
      format.html { redirect_to curriculums_url, notice: 'El curriculum se eliminó correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curriculum
      @curriculum = Curriculum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def curriculum_params
      params.require(:curriculum).permit(:calle, :colonia, :municipui, :entidad, :correo, :telefono, :celular, :lugar, :foto, :nombre, :paterno, :materno)
    end
end
