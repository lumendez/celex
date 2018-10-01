class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :user, only: :create
  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    #@users = User.all.order("paterno ASC").page params[:pagina]
      @filterrific = initialize_filterrific(
      User,
      params[:filterrific],
      select_options: {
        with_role_id: Role.options_for_select
      },
    ) or return
    @users = @filterrific.find.page(params[:pagina])

    respond_to do |format|
      format.html
      format.js
    end

    rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @inscripcion_registros = InscripcionRegistro.where(user_id: @user.id)
    @fr_inscripcion_registros = FrInscripcionRegistro.where(user_id: @user.id)
    @it_inscripcion_registros = ItInscripcionRegistro.where(user_id: @user.id)
    @examenes_colocacion = ExamenColocacionIdioma.where(user_id: @user.id).count
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'El usuario se ha creado correctamente.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'El usuario se ha actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'El usuario se ha eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  def instructores
    @users = User.instructores.order(:paterno).page params[:pagina]
  end

  def historial_academico_ingles
    #@inscripcion_registros = InscripcionRegistro.where(nombre: @user.nombre, paterno: @user.paterno, materno: @user.materno, idioma: 'Inglés').last
    @inscripcion_registros = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés').last
    @examen_colocacion = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés').last

    @basico1 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Básico 1").last
    @basico2 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Básico 2").last
    @basico3 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Básico 3").last
    @basico4 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Básico 4").last
    @basico5 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Básico 5").last
    @intermedio1 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Intermedio 1").last
    @intermedio2 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Intermedio 2").last
    @intermedio3 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Intermedio 3").last
    @intermedio4 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Intermedio 4").last
    @intermedio5 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Intermedio 5").last
    @avanzado1 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Avanzado 1").last
    @avanzado2 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Avanzado 2").last
    @avanzado3 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Avanzado 3").last
    @avanzado4 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Avanzado 4").last
    @avanzado5 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Avanzado 5").last
    @b21 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Certificación del Nivel de Dominio B2.1").last
    @b22 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Certificación del Nivel de Dominio B2.2").last
    @b23 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Certificación del Nivel de Dominio B2.3").last

    @examen_basico1 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés', nivel_asignado: "Básico 1").last
    @examen_basico2 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés', nivel_asignado: "Básico 2").last
    @examen_basico3 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés', nivel_asignado: "Básico 3").last
    @examen_basico4 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés', nivel_asignado: "Básico 4").last
    @examen_basico5 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés', nivel_asignado: "Básico 5").last
    @examen_intermedio1 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés', nivel_asignado: "Intermedio 1").last
    @examen_intermedio2 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés', nivel_asignado: "Intermedio 2").last
    @examen_intermedio3 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés', nivel_asignado: "Intermedio 3").last
    @examen_intermedio4 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés', nivel_asignado: "Intermedio 4").last
    @examen_intermedio5 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés', nivel_asignado: "Intermedio 5").last
    @examen_avanzado1 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés', nivel_asignado: "Avanzado 1").last
    @examen_avanzado2 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés', nivel_asignado: "Avanzado 2").last
    @examen_avanzado3 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés', nivel_asignado: "Avanzado 3").last
    @examen_avanzado4 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés', nivel_asignado: "Avanzado 4").last
    @examen_avanzado5 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Inglés', nivel_asignado: "Avanzado 5").last

    if @inscripcion_registros.nil?
      @mcer = "Este usuario no tiene ningún registro de inscripción"
    elsif @inscripcion_registros.nivel == "Básico 1" || @inscripcion_registros.nivel == "Básico 2"
      @mcer = "A1"
    elsif @inscripcion_registros.nivel == "Básico 3" || @inscripcion_registros.nivel == "Básico 4" || @inscripcion_registros.nivel == "Básico 5"
      @mcer = "A2"
    elsif @inscripcion_registros.nivel == "Intemedio 1" || @inscripcion_registros.nivel == "Intermedio 2" || @inscripcion_registros.nivel == "Intermedio 3" || @inscripcion_registros.nivel == "Intermedio 4" || @inscripcion_registros.nivel == "Intermedio 5"
      @mcer = "B1"
    elsif @inscripcion_registros.nivel == "Avanzado 1" || @inscripcion_registros.nivel == "Avanzado 2" || @inscripcion_registros.nivel == "Avanzado 3" || @inscripcion_registros.nivel == "Avanzado 4" || @inscripcion_registros.nivel == "Avanzado 5"
      @mcer = "B2"
    end

    if @inscripcion_registros.nil?
      @mensaje_mcer = "Este usuario no tiene ningún registro de inscripción"
    elsif @inscripcion_registros.nivel == "Básico 1" || @inscripcion_registros.nivel == "Básico 2" && @inscripcion_registros.promedio < 80
      @mensaje_mcer = "se encuentra desarrollando los estudios correspondientes al nivel A1"
    elsif @inscripcion_registros.nivel == "Básico 2" && @inscripcion_registros.promedio >= 80 || @inscripcion_registros.nivel == "Básico 3" || @inscripcion_registros.nivel == "Básico 4" || @inscripcion_registros.nivel == "Básico 5" && @inscripcion_registros.promedio < 80
      @mensaje_mcer = "ha concuido los estudios correspondientes al nivel A1"
    elsif @inscripcion_registros.nivel == "Básico 5" && @inscripcion_registros.promedio >= 80 || @inscripcion_registros.nivel == "Intermedio 1" || @inscripcion_registros.nivel == "Intermedio 2" || @inscripcion_registros.nivel == "Intermedio 3" || @inscripcion_registros.nivel == "Intermedio 4" || @inscripcion_registros.nivel == "Intermedio 5" && @inscripcion_registros.promedio < 80
      @mensaje_mcer = "ha concuido los estudios correspondientes al nivel A2"
    elsif @inscripcion_registros.nivel == "Intermedio 5" && @inscripcion_registros.promedio >= 80 || @inscripcion_registros.nivel == "Avanzado 1" || @inscripcion_registros.nivel == "Avanzado 2" || @inscripcion_registros.nivel == "Avanzado 3" || @inscripcion_registros.nivel == "Avanzado 4" || @inscripcion_registros.nivel == "Avanzado 5" && @inscripcion_registros.promedio < 80
      @mensaje_mcer = "ha concuido los estudios correspondientes al nivel B1"
    elsif @inscripcion_registros.nivel == "Avanzado 5" && @inscripcion_registros.promedio >= 80 ||  @inscripcion_registros.nivel == "Certificación del Nivel de Dominio B2.1" || @inscripcion_registros.nivel == "Certificación del Nivel de Dominio B2.2" || @inscripcion_registros.nivel == "Certificación del Nivel de Dominio B2.3"
      @mensaje_mcer = "ha concuido los estudios correspondientes al nivel B2"
    end

    if @basico1.present? && @basico1.examen_medio.present? == true && @basico1.examen_final.present?  == true && @basico1.promedio >= 80
      b1horas = 40
    else
      b1horas = 0
    end
    if @basico2.present? && @basico2.examen_medio.present? == true && @basico2.examen_final.present?  == true && @basico2.promedio >= 80
      b2horas = 40
    else
      b2horas = 0
    end
    if @basico3.present? && @basico3.examen_medio.present? == true && @basico3.examen_final.present?  == true && @basico3.promedio >= 80
      b3horas = 40
    else
      b3horas = 0
    end
    if @basico4.present? && @basico4.examen_medio.present? == true && @basico4.examen_final.present?  == true && @basico4.promedio >= 80
      b4horas = 40
    else
      b4horas = 0
    end
    if @basico5.present? && @basico5.examen_medio.present? == true && @basico5.examen_final.present?  == true && @basico5.promedio >= 80
      b5horas = 40
    else
      b5horas = 0
    end
    if @intermedio1.present? && @intermedio1.examen_medio.present? == true && @intermedio1.examen_final.present?  == true && @intermedio1.promedio >= 80
      i1horas = 40
    else
      i1horas = 0
    end
    if @intermedio2.present? && @intermedio2.examen_medio.present? == true && @intermedio2.examen_final.present?  == true && @intermedio2.promedio >= 80
      i2horas = 40
    else
      i2horas = 0
    end
    if @intermedio3.present? && @intermedio3.examen_medio.present? == true && @intermedio3.examen_final.present?  == true && @intermedio3.promedio >= 80
      i3horas = 40
    else
      i3horas = 0
    end
    if @intermedio4.present? && @intermedio4.examen_medio.present? == true && @intermedio4.examen_final.present?  == true && @intermedio4.promedio >= 80
      i4horas = 40
    else
      i4horas = 0
    end
    if @intermedio5.present? && @intermedio5.examen_medio.present? == true && @intermedio5.examen_final.present?  == true && @intermedio5.promedio >= 80
      i5horas = 40
    else
      i5horas = 0
    end
    if @avanzado1.present? && @avanzado1.examen_medio.present? == true && @avanzado1.examen_final.present?  == true && @avanzado1.promedio >= 80
      a1horas = 40
    else
      a1horas = 0
    end
    if @avanzado2.present? && @avanzado2.examen_medio.present? == true && @avanzado2.examen_final.present?  == true && @avanzado2.promedio >= 80
      a2horas = 40
    else
      a2horas = 0
    end
    if @avanzado3.present? && @avanzado3.examen_medio.present? == true && @avanzado3.examen_final.present?  == true && @avanzado3.promedio >= 80
      a3horas = 40
    else
      a3horas = 0
    end
    if @avanzado4.present? && @avanzado4.examen_medio.present? == true && @avanzado4.examen_final.present?  == true && @avanzado4.promedio >= 80
      a4horas = 40
    else
      a4horas = 0
    end
    if @avanzado5.present? && @avanzado5.examen_medio.present? == true && @avanzado5.examen_final.present?  == true && @avanzado5.promedio >= 80
      a5horas = 40
    else
      a5horas = 0
    end

    @horas = b1horas + b2horas + b3horas + b4horas + b5horas + i1horas +
    i2horas + i3horas + i4horas + i5horas + a1horas + a2horas + a3horas +
    a4horas + a5horas

    fecha = Date.today
    @dias = fecha.day
    if fecha.month == 1
      @mes = "enero"
    elsif fecha.month == 2
      @mes = "febrero"
    elsif fecha.month == 3
      @mes = "marzo"
    elsif fecha.month == 4
      @mes = "abril"
    elsif fecha.month == 5
      @mes = "mayo"
    elsif fecha.month == 6
      @mes = "junio"
    elsif fecha.month == 7
      @mes = "julio"
    elsif fecha.month == 8
      @mes = "agosto"
    elsif fecha.month == 9
      @mes = "septiembre"
    elsif fecha.month == 10
      @mes = "octubre"
    elsif fecha.month == 11
      @mes = "noviembre"
    elsif fecha.month == 12
      @mes = "diciembre"
    end

    if fecha.year == 2017
      @anio = "dos mil diecisiete"
    elsif fecha.year == 2018
      @anio = "dos mil dieciocho"
    elsif fecha.year == 2019
      @anio = "dos mil diecinueve"
    elsif fecha.year == 2020
      @anio = "dos mil veinte"
    end

    respond_to do |format|
     format.pdf do
       render pdf: "historial_academico_#{@inscripcion_registros.nombre}_#{@inscripcion_registros.paterno}_#{@inscripcion_registros.materno}",
       disposition: "attachment",
       template: "users/historial_ingles.html.erb",
       layout: "historial_academico_ingles.html.erb",
       page_size: "Letter",
       margin: {top: 8}
     end
    end
  end

  def historiales_ingles
    @filterrific = initialize_filterrific(
    User.alumnos.order(:paterno),
    params[:filterrific],
  ) or return
  @users = @filterrific.find.page(params[:pagina])

  respond_to do |format|
    format.html
    format.js
  end

  rescue ActiveRecord::RecordNotFound => e
  # There is an issue with the persisted param_set. Reset it.
  puts "Had to reset filterrific params: #{ e.message }"
  redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def historial_ingles
  end

  def historial_academico_frances
    @fr_inscripcion_registros = FrInscripcionRegistro.where(nombre: @user.nombre, paterno: @user.paterno, materno: @user.materno, idioma: 'Francés').last
    @fr_examen_colocacion = ExamenColocacionIdioma.find_by(user_id: @user.id, idioma: 'Francés')

    @basico1 = FrInscripcionRegistro.where(user_id: @user.id, idioma: 'Francés', nivel: "Básico 1").last
    @basico2 = FrInscripcionRegistro.where(user_id: @user.id, idioma: 'Francés', nivel: "Básico 2").last
    @basico3 = FrInscripcionRegistro.where(user_id: @user.id, idioma: 'Francés', nivel: "Básico 3").last
    @basico4 = FrInscripcionRegistro.where(user_id: @user.id, idioma: 'Francés', nivel: "Básico 4").last
    @basico5 = FrInscripcionRegistro.where(user_id: @user.id, idioma: 'Francés', nivel: "Básico 5").last
    @intermedio1 = FrInscripcionRegistro.where(user_id: @user.id, idioma: 'Francés', nivel: "Intermedio 1").last
    @intermedio2 = FrInscripcionRegistro.where(user_id: @user.id, idioma: 'Francés', nivel: "Intermedio 2").last
    @intermedio3 = FrInscripcionRegistro.where(user_id: @user.id, idioma: 'Francés', nivel: "Intermedio 3").last
    @intermedio4 = FrInscripcionRegistro.where(user_id: @user.id, idioma: 'Francés', nivel: "Intermedio 4").last
    @intermedio5 = FrInscripcionRegistro.where(user_id: @user.id, idioma: 'Francés', nivel: "Intermedio 5").last
    @avanzado1 = FrInscripcionRegistro.where(user_id: @user.id, idioma: 'Francés', nivel: "Avanzado 1").last
    @avanzado2 = FrInscripcionRegistro.where(user_id: @user.id, idioma: 'Francés', nivel: "Avanzado 2").last
    @avanzado3 = FrInscripcionRegistro.where(user_id: @user.id, idioma: 'Francés', nivel: "Avanzado 3").last
    @avanzado4 = FrInscripcionRegistro.where(user_id: @user.id, idioma: 'Francés', nivel: "Avanzado 4").last
    @avanzado5 = FrInscripcionRegistro.where(user_id: @user.id, idioma: 'Francés', nivel: "Avanzado 5").last

    @examen_basico1 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Francés', nivel_asignado: "Básico 1").last
    @examen_basico2 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Francés', nivel_asignado: "Básico 2").last
    @examen_basico3 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Francés', nivel_asignado: "Básico 3").last
    @examen_basico4 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Francés', nivel_asignado: "Básico 4").last
    @examen_basico5 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Francés', nivel_asignado: "Básico 5").last
    @examen_intermedio1 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Francés', nivel_asignado: "Intermedio 1").last
    @examen_intermedio2 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Francés', nivel_asignado: "Intermedio 2").last
    @examen_intermedio3 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Francés', nivel_asignado: "Intermedio 3").last
    @examen_intermedio4 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Francés', nivel_asignado: "Intermedio 4").last
    @examen_intermedio5 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Francés', nivel_asignado: "Intermedio 5").last
    @examen_avanzado1 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Francés', nivel_asignado: "Avanzado 1").last
    @examen_avanzado2 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Francés', nivel_asignado: "Avanzado 2").last
    @examen_avanzado3 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Francés', nivel_asignado: "Avanzado 3").last
    @examen_avanzado4 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Francés', nivel_asignado: "Avanzado 4").last
    @examen_avanzado5 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Francés', nivel_asignado: "Avanzado 5").last

    if @fr_inscripcion_registros.nil?
      @mcer = "Este usuario no tiene ningún registro de inscripción"
    elsif @fr_inscripcion_registros.nivel == "Básico 1" || @fr_inscripcion_registros.nivel == "Básico 2"
      @mcer = "A1"
    elsif @fr_inscripcion_registros.nivel == "Básico 3" || @fr_inscripcion_registros.nivel == "Básico 4" || @fr_inscripcion_registros.nivel == "Básico 5"
      @mcer = "A2"
    elsif @fr_inscripcion_registros.nivel == "Intemedio 1" || @fr_inscripcion_registros.nivel == "Intermedio 2" || @fr_inscripcion_registros.nivel == "Intermedio 3" || @fr_inscripcion_registros.nivel == "Intermedio 4" || @fr_inscripcion_registros.nivel == "Intermedio 5"
      @mcer = "B1"
    elsif @fr_inscripcion_registros.nivel == "Avanzado 1" || @fr_inscripcion_registros.nivel == "Avanzado 2" || @fr_inscripcion_registros.nivel == "Avanzado 3" || @fr_inscripcion_registros.nivel == "Avanzado 4" || @fr_inscripcion_registros.nivel == "Avanzado 5"
      @mcer = "B2"
    end

    if @fr_inscripcion_registros.nil?
      @mensaje_mcer = "Este usuario no tiene ningún registro de inscripción"
    elsif @fr_inscripcion_registros.nivel == "Básico 1" || @fr_inscripcion_registros.nivel == "Básico 2" && @fr_inscripcion_registros.promedio < 80
      @mensaje_mcer = "se encuentra desarrollando los estudios correspondientes al nivel A1"
    elsif @fr_inscripcion_registros.nivel == "Básico 2" && @fr_inscripcion_registros.promedio >= 80 || @fr_inscripcion_registros.nivel == "Básico 3" || @fr_inscripcion_registros.nivel == "Básico 4" || @fr_inscripcion_registros.nivel == "Básico 5" && @fr_inscripcion_registros.promedio < 80
      @mensaje_mcer = "ha concuido los estudios correspondientes al nivel A1"
    elsif @fr_inscripcion_registros.nivel == "Básico 5" && @fr_inscripcion_registros.promedio >= 80 || @fr_inscripcion_registros.nivel == "Intemedio 1" || @fr_inscripcion_registros.nivel == "Intermedio 2" || @fr_inscripcion_registros.nivel == "Intermedio 3" || @fr_inscripcion_registros.nivel == "Intermedio 4" || @fr_inscripcion_registros.nivel == "Intermedio 5" && @fr_inscripcion_registros.promedio < 80
      @mensaje_mcer = "ha concuido los estudios correspondientes al nivel A2"
    elsif @fr_inscripcion_registros.nivel == "Intermedio 5" && @fr_inscripcion_registros.promedio >= 80 || @fr_inscripcion_registros.nivel == "Avanzado 1" || @fr_inscripcion_registros.nivel == "Avanzado 2" || @fr_inscripcion_registros.nivel == "Avanzado 3" || @fr_inscripcion_registros.nivel == "Avanzado 4" || @fr_inscripcion_registros.nivel == "Avanzado 5" && @fr_inscripcion_registros.promedio < 80
      @mensaje_mcer = "ha concuido los estudios correspondientes al nivel B1"
    elsif @fr_inscripcion_registros.nivel == "Avanzado 5" && @fr_inscripcion_registros.promedio >= 80
      @mensaje_mcer = "ha concuido los estudios correspondientes al nivel B2"
    end

    if @basico1.present? && @basico1.examen_medio.present? == true && @basico1.examen_final.present?  == true && @basico1.promedio >= 80
      b1horas = 40
    else
      b1horas = 0
    end
    if @basico2.present? && @basico2.examen_medio.present? == true && @basico2.examen_final.present?  == true && @basico2.promedio >= 80
      b2horas = 40
    else
      b2horas = 0
    end
    if @basico3.present? && @basico3.examen_medio.present? == true && @basico3.examen_final.present?  == true && @basico3.promedio >= 80
      b3horas = 40
    else
      b3horas = 0
    end
    if @basico4.present? && @basico4.examen_medio.present? == true && @basico4.examen_final.present?  == true && @basico4.promedio >= 80
      b4horas = 40
    else
      b4horas = 0
    end
    if @basico5.present? && @basico5.examen_medio.present? == true && @basico5.examen_final.present?  == true && @basico5.promedio >= 80
      b5horas = 40
    else
      b5horas = 0
    end
    if @intermedio1.present? && @intermedio1.examen_medio.present? == true && @intermedio1.examen_final.present?  == true && @intermedio1.promedio >= 80
      i1horas = 40
    else
      i1horas = 0
    end
    if @intermedio2.present? && @intermedio2.examen_medio.present? == true && @intermedio2.examen_final.present?  == true && @intermedio2.promedio >= 80
      i2horas = 40
    else
      i2horas = 0
    end
    if @intermedio3.present? && @intermedio3.examen_medio.present? == true && @intermedio3.examen_final.present?  == true && @intermedio3.promedio >= 80
      i3horas = 40
    else
      i3horas = 0
    end
    if @intermedio4.present? && @intermedio4.examen_medio.present? == true && @intermedio4.examen_final.present?  == true && @intermedio4.promedio >= 80
      i4horas = 40
    else
      i4horas = 0
    end
    if @intermedio5.present? && @intermedio5.examen_medio.present? == true && @intermedio5.examen_final.present?  == true && @intermedio5.promedio >= 80
      i5horas = 40
    else
      i5horas = 0
    end
    if @avanzado1.present? && @avanzado1.examen_medio.present? == true && @avanzado1.examen_final.present?  == true && @avanzado1.promedio >= 80
      a1horas = 40
    else
      a1horas = 0
    end
    if @avanzado2.present? && @avanzado2.examen_medio.present? == true && @avanzado2.examen_final.present?  == true && @avanzado2.promedio >= 80
      a2horas = 40
    else
      a2horas = 0
    end
    if @avanzado3.present? && @avanzado3.examen_medio.present? == true && @avanzado3.examen_final.present?  == true && @avanzado3.promedio >= 80
      a3horas = 40
    else
      a3horas = 0
    end
    if @avanzado4.present? && @avanzado4.examen_medio.present? == true && @avanzado4.examen_final.present?  == true && @avanzado4.promedio >= 80
      a4horas = 40
    else
      a4horas = 0
    end
    if @avanzado5.present? && @avanzado5.examen_medio.present? == true && @avanzado5.examen_final.present?  == true && @avanzado5.promedio >= 80
      a5horas = 40
    else
      a5horas = 0
    end

    @horas = b1horas + b2horas + b3horas + b4horas + b5horas + i1horas +
    i2horas + i3horas + i4horas + i5horas + a1horas + a2horas + a3horas +
    a4horas + a5horas

    fecha = Date.today
    @dias = fecha.day
    if fecha.month == 1
      @mes = "enero"
    elsif fecha.month == 2
      @mes = "febrero"
    elsif fecha.month == 3
      @mes = "marzo"
    elsif fecha.month == 4
      @mes = "abril"
    elsif fecha.month == 5
      @mes = "mayo"
    elsif fecha.month == 6
      @mes = "junio"
    elsif fecha.month == 7
      @mes = "julio"
    elsif fecha.month == 8
      @mes = "agosto"
    elsif fecha.month == 9
      @mes = "septiembre"
    elsif fecha.month == 10
      @mes = "octubre"
    elsif fecha.month == 11
      @mes = "noviembre"
    elsif fecha.month == 12
      @mes = "diciembre"
    end

    if fecha.year == 2017
      @anio = "dos mil diecisiete"
    elsif fecha.year == 2018
      @anio = "dos mil dieciocho"
    elsif fecha.year == 2019
      @anio = "dos mil diecinueve"
    elsif fecha.year == 2020
      @anio = "dos mil veinte"
    end

    respond_to do |format|
     format.pdf do
       render pdf: "historial_academico_#{@fr_inscripcion_registros.nombre}_#{@fr_inscripcion_registros.paterno}_#{@fr_inscripcion_registros.materno}",
       disposition: "attachment",
       template: "users/historial_frances.html.erb",
       layout: "historial_academico_ingles.html.erb",
       page_size: "Letter",
       margin: {top: 8}
     end
    end
  end

  def historiales_frances
    @filterrific = initialize_filterrific(
    User.alumnos.order(:paterno),
    params[:filterrific],
  ) or return
  @users = @filterrific.find.page(params[:pagina])

  respond_to do |format|
    format.html
    format.js
  end

  rescue ActiveRecord::RecordNotFound => e
  # There is an issue with the persisted param_set. Reset it.
  puts "Had to reset filterrific params: #{ e.message }"
  redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def historial_frances
  end

  def historial_academico_italiano
    @it_inscripcion_registros = ItInscripcionRegistro.where(nombre: @user.nombre, paterno: @user.paterno, materno: @user.materno, idioma: 'Italiano').last
    @it_examen_colocacion = ExamenColocacionIdioma.find_by(user_id: @user.id, idioma: 'Italiano')

    @basico1 = ItInscripcionRegistro.where(user_id: @user.id, idioma: 'Italiano', nivel: "Básico 1").last
    @basico2 = ItInscripcionRegistro.where(user_id: @user.id, idioma: 'Italiano', nivel: "Básico 2").last
    @basico3 = ItInscripcionRegistro.where(user_id: @user.id, idioma: 'Italiano', nivel: "Básico 3").last
    @basico4 = ItInscripcionRegistro.where(user_id: @user.id, idioma: 'Italiano', nivel: "Básico 4").last
    @basico5 = ItInscripcionRegistro.where(user_id: @user.id, idioma: 'Italiano', nivel: "Básico 5").last
    @intermedio1 = ItInscripcionRegistro.where(user_id: @user.id, idioma: 'Italiano', nivel: "Intermedio 1").last
    @intermedio2 = ItInscripcionRegistro.where(user_id: @user.id, idioma: 'Italiano', nivel: "Intermedio 2").last
    @intermedio3 = ItInscripcionRegistro.where(user_id: @user.id, idioma: 'Italiano', nivel: "Intermedio 3").last
    @intermedio4 = ItInscripcionRegistro.where(user_id: @user.id, idioma: 'Italiano', nivel: "Intermedio 4").last
    @intermedio5 = ItInscripcionRegistro.where(user_id: @user.id, idioma: 'Italiano', nivel: "Intermedio 5").last
    @avanzado1 = ItInscripcionRegistro.where(user_id: @user.id, idioma: 'Italiano', nivel: "Avanzado 1").last
    @avanzado2 = ItInscripcionRegistro.where(user_id: @user.id, idioma: 'Italiano', nivel: "Avanzado 2").last
    @avanzado3 = ItInscripcionRegistro.where(user_id: @user.id, idioma: 'Italiano', nivel: "Avanzado 3").last
    @avanzado4 = ItInscripcionRegistro.where(user_id: @user.id, idioma: 'Italiano', nivel: "Avanzado 4").last
    @avanzado5 = ItInscripcionRegistro.where(user_id: @user.id, idioma: 'Italiano', nivel: "Avanzado 5").last

    @examen_basico1 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Italiano', nivel_asignado: "Básico 1").last
    @examen_basico2 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Italiano', nivel_asignado: "Básico 2").last
    @examen_basico3 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Italiano', nivel_asignado: "Básico 3").last
    @examen_basico4 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Italiano', nivel_asignado: "Básico 4").last
    @examen_basico5 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Italiano', nivel_asignado: "Básico 5").last
    @examen_intermedio1 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Italiano', nivel_asignado: "Intermedio 1").last
    @examen_intermedio2 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Italiano', nivel_asignado: "Intermedio 2").last
    @examen_intermedio3 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Italiano', nivel_asignado: "Intermedio 3").last
    @examen_intermedio4 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Italiano', nivel_asignado: "Intermedio 4").last
    @examen_intermedio5 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Italiano', nivel_asignado: "Intermedio 5").last
    @examen_avanzado1 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Italiano', nivel_asignado: "Avanzado 1").last
    @examen_avanzado2 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Italiano', nivel_asignado: "Avanzado 2").last
    @examen_avanzado3 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Italiano', nivel_asignado: "Avanzado 3").last
    @examen_avanzado4 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Italiano', nivel_asignado: "Avanzado 4").last
    @examen_avanzado5 = ExamenColocacionIdioma.where(user_id: @user.id, idioma: 'Italiano', nivel_asignado: "Avanzado 5").last

    if @it_inscripcion_registros.nil?
      @mcer = "Este usuario no tiene ningún registro de inscripción"
    elsif @it_inscripcion_registros.nivel == "Básico 1" || @it_inscripcion_registros.nivel == "Básico 2"
      @mcer = "A1"
    elsif @it_inscripcion_registros.nivel == "Básico 3" || @it_inscripcion_registros.nivel == "Básico 4" || @it_inscripcion_registros.nivel == "Básico 5"
      @mcer = "A2"
    elsif @it_inscripcion_registros.nivel == "Intemedio 1" || @it_inscripcion_registros.nivel == "Intermedio 2" || @it_inscripcion_registros.nivel == "Intermedio 3" || @it_inscripcion_registros.nivel == "Intermedio 4" || @it_inscripcion_registros.nivel == "Intermedio 5"
      @mcer = "B1"
    elsif @it_inscripcion_registros.nivel == "Avanzado 1" || @it_inscripcion_registros.nivel == "Avanzado 2" || @it_inscripcion_registros.nivel == "Avanzado 3" || @it_inscripcion_registros.nivel == "Avanzado 4" || @it_inscripcion_registros.nivel == "Avanzado 5"
      @mcer = "B2"
    end

    if @it_inscripcion_registros.nil?
      @mensaje_mcer = "Este usuario no tiene ningún registro de inscripción"
    elsif @it_inscripcion_registros.nivel == "Básico 1" || @it_inscripcion_registros.nivel == "Básico 2" && @it_inscripcion_registros.promedio < 80
      @mensaje_mcer = "se encuentra desarrollando los estudios correspondientes al nivel A1"
    elsif @it_inscripcion_registros.nivel == "Básico 2" && @it_inscripcion_registros.promedio >= 80 || @it_inscripcion_registros.nivel == "Básico 3" || @it_inscripcion_registros.nivel == "Básico 4" || @it_inscripcion_registros.nivel == "Básico 5" && @it_inscripcion_registros.promedio < 80
      @mensaje_mcer = "ha concuido los estudios correspondientes al nivel A1"
    elsif @it_inscripcion_registros.nivel == "Básico 5" && @it_inscripcion_registros.promedio >= 80 || @it_inscripcion_registros.nivel == "Intemedio 1" || @it_inscripcion_registros.nivel == "Intermedio 2" || @it_inscripcion_registros.nivel == "Intermedio 3" || @it_inscripcion_registros.nivel == "Intermedio 4" || @it_inscripcion_registros.nivel == "Intermedio 5" && @it_inscripcion_registros.promedio < 80
      @mensaje_mcer = "ha concuido los estudios correspondientes al nivel A2"
    elsif @it_inscripcion_registros.nivel == "Intermedio 5" && @it_inscripcion_registros.promedio >= 80 || @it_inscripcion_registros.nivel == "Avanzado 1" || @it_inscripcion_registros.nivel == "Avanzado 2" || @it_inscripcion_registros.nivel == "Avanzado 3" || @it_inscripcion_registros.nivel == "Avanzado 4" || @it_inscripcion_registros.nivel == "Avanzado 5" && @it_inscripcion_registros.promedio < 80
      @mensaje_mcer = "ha concuido los estudios correspondientes al nivel B1"
    elsif @it_inscripcion_registros.nivel == "Avanzado 5" && @it_inscripcion_registros.promedio >= 80
      @mensaje_mcer = "ha concuido los estudios correspondientes al nivel B2"
    end

    if @basico1.present? && @basico1.examen_medio.present? == true && @basico1.examen_final.present?  == true && @basico1.promedio >= 80
      b1horas = 40
    else
      b1horas = 0
    end
    if @basico2.present? && @basico2.examen_medio.present? == true && @basico2.examen_final.present?  == true && @basico2.promedio >= 80
      b2horas = 40
    else
      b2horas = 0
    end
    if @basico3.present? && @basico3.examen_medio.present? == true && @basico3.examen_final.present?  == true && @basico3.promedio >= 80
      b3horas = 40
    else
      b3horas = 0
    end
    if @basico4.present? && @basico4.examen_medio.present? == true && @basico4.examen_final.present?  == true && @basico4.promedio >= 80
      b4horas = 40
    else
      b4horas = 0
    end
    if @basico5.present? && @basico5.examen_medio.present? == true && @basico5.examen_final.present?  == true && @basico5.promedio >= 80
      b5horas = 40
    else
      b5horas = 0
    end
    if @intermedio1.present? && @intermedio1.examen_medio.present? == true && @intermedio1.examen_final.present?  == true && @intermedio1.promedio >= 80
      i1horas = 40
    else
      i1horas = 0
    end
    if @intermedio2.present? && @intermedio2.examen_medio.present? == true && @intermedio2.examen_final.present?  == true && @intermedio2.promedio >= 80
      i2horas = 40
    else
      i2horas = 0
    end
    if @intermedio3.present? && @intermedio3.examen_medio.present? == true && @intermedio3.examen_final.present?  == true && @intermedio3.promedio >= 80
      i3horas = 40
    else
      i3horas = 0
    end
    if @intermedio4.present? && @intermedio4.examen_medio.present? == true && @intermedio4.examen_final.present?  == true && @intermedio4.promedio >= 80
      i4horas = 40
    else
      i4horas = 0
    end
    if @intermedio5.present? && @intermedio5.examen_medio.present? == true && @intermedio5.examen_final.present?  == true && @intermedio5.promedio >= 80
      i5horas = 40
    else
      i5horas = 0
    end
    if @avanzado1.present? && @avanzado1.examen_medio.present? == true && @avanzado1.examen_final.present?  == true && @avanzado1.promedio >= 80
      a1horas = 40
    else
      a1horas = 0
    end
    if @avanzado2.present? && @avanzado2.examen_medio.present? == true && @avanzado2.examen_final.present?  == true && @avanzado2.promedio >= 80
      a2horas = 40
    else
      a2horas = 0
    end
    if @avanzado3.present? && @avanzado3.examen_medio.present? == true && @avanzado3.examen_final.present?  == true && @avanzado3.promedio >= 80
      a3horas = 40
    else
      a3horas = 0
    end
    if @avanzado4.present? && @avanzado4.examen_medio.present? == true && @avanzado4.examen_final.present?  == true && @avanzado4.promedio >= 80
      a4horas = 40
    else
      a4horas = 0
    end
    if @avanzado5.present? && @avanzado5.examen_medio.present? == true && @avanzado5.examen_final.present?  == true && @avanzado5.promedio >= 80
      a5horas = 40
    else
      a5horas = 0
    end

    @horas = b1horas + b2horas + b3horas + b4horas + b5horas + i1horas +
    i2horas + i3horas + i4horas + i5horas + a1horas + a2horas + a3horas +
    a4horas + a5horas

    fecha = Date.today
    @dias = fecha.day
    if fecha.month == 1
      @mes = "enero"
    elsif fecha.month == 2
      @mes = "febrero"
    elsif fecha.month == 3
      @mes = "marzo"
    elsif fecha.month == 4
      @mes = "abril"
    elsif fecha.month == 5
      @mes = "mayo"
    elsif fecha.month == 6
      @mes = "junio"
    elsif fecha.month == 7
      @mes = "julio"
    elsif fecha.month == 8
      @mes = "agosto"
    elsif fecha.month == 9
      @mes = "septiembre"
    elsif fecha.month == 10
      @mes = "octubre"
    elsif fecha.month == 11
      @mes = "noviembre"
    elsif fecha.month == 12
      @mes = "diciembre"
    end

    if fecha.year == 2017
      @anio = "dos mil diecisiete"
    elsif fecha.year == 2018
      @anio = "dos mil dieciocho"
    elsif fecha.year == 2019
      @anio = "dos mil diecinueve"
    elsif fecha.year == 2020
      @anio = "dos mil veinte"
    end

    respond_to do |format|
     format.pdf do
       render pdf: "historial_academico_#{@it_inscripcion_registros.nombre}_#{@it_inscripcion_registros.paterno}_#{@it_inscripcion_registros.materno}",
       disposition: "attachment",
       template: "users/historial_italiano.html.erb",
       layout: "historial_academico_ingles.html.erb",
       page_size: "Letter",
       margin: {top: 8}
     end
    end
  end

  def historiales_italiano
    @filterrific = initialize_filterrific(
    User.alumnos.order(:paterno),
    params[:filterrific],
  ) or return
  @users = @filterrific.find.page(params[:pagina])

  respond_to do |format|
    format.html
    format.js
  end

  rescue ActiveRecord::RecordNotFound => e
  # There is an issue with the persisted param_set. Reset it.
  puts "Had to reset filterrific params: #{ e.message }"
  redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def historial_italiano
  end

  def historial_academico_b2
    @inscripcion_registros = InscripcionRegistro.where(nombre: @user.nombre, paterno: @user.paterno, materno: @user.materno, idioma: 'Inglés').last

    @b21 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Certificación del Nivel de Dominio B2.1").last
    @b22 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Certificación del Nivel de Dominio B2.2").last
    @b23 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Certificación del Nivel de Dominio B2.3").last


    if @b21.present? && @b21.examen_medio.present? == true && @b21.examen_final.present?  == true && @b21.promedio >= 80
      b1horas = 40
    else
      b1horas = 0
    end
    if @b22.present? && @b22.examen_medio.present? == true && @b22.examen_final.present?  == true && @b22.promedio >= 80
      b2horas = 40
    else
      b2horas = 0
    end
    if @b23.present? && @b23.examen_medio.present? == true && @b23.examen_final.present?  == true && @b23.promedio >= 80
      b3horas = 40
    else
      b3horas = 0
    end

    @horas = b1horas + b2horas + b3horas

    fecha = Date.today
    @dias = fecha.day
    if fecha.month == 1
      @mes = "enero"
    elsif fecha.month == 2
      @mes = "febrero"
    elsif fecha.month == 3
      @mes = "marzo"
    elsif fecha.month == 4
      @mes = "abril"
    elsif fecha.month == 5
      @mes = "mayo"
    elsif fecha.month == 6
      @mes = "junio"
    elsif fecha.month == 7
      @mes = "julio"
    elsif fecha.month == 8
      @mes = "agosto"
    elsif fecha.month == 9
      @mes = "septiembre"
    elsif fecha.month == 10
      @mes = "octubre"
    elsif fecha.month == 11
      @mes = "noviembre"
    elsif fecha.month == 12
      @mes = "diciembre"
    end

    if fecha.year == 2017
      @anio = "dos mil diecisiete"
    elsif fecha.year == 2018
      @anio = "dos mil dieciocho"
    elsif fecha.year == 2019
      @anio = "dos mil diecinueve"
    elsif fecha.year == 2020
      @anio = "dos mil veinte"
    end

    respond_to do |format|
     format.pdf do
       render pdf: "historial_academico_#{@inscripcion_registros.nombre}_#{@inscripcion_registros.paterno}_#{@inscripcion_registros.materno}",
       disposition: "attachment",
       template: "users/historial_b2.html.erb",
       layout: "historial_academico_ingles.html.erb",
       page_size: "Letter",
       margin: {top: 8}
     end
    end
  end

  def historiales_b2
    @filterrific = initialize_filterrific(
    User.alumnos.order(:paterno),
    params[:filterrific],
  ) or return
  @users = @filterrific.find.page(params[:pagina])

  respond_to do |format|
    format.html
    format.js
  end

  rescue ActiveRecord::RecordNotFound => e
  # There is an issue with the persisted param_set. Reset it.
  puts "Had to reset filterrific params: #{ e.message }"
  redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def historial_b2
  end

  def historial_academico_tkt
    @inscripcion_registros = InscripcionRegistro.where(nombre: @user.nombre, paterno: @user.paterno, materno: @user.materno, idioma: 'Inglés').last

    @tkt1 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Certificación de Metodología TKT 1").last
    @tkt2 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Certificación de Metodología TKT 2").last
    @tkt3 = InscripcionRegistro.where(user_id: @user.id, idioma: 'Inglés', nivel: "Certificación de Metodología TKT 3").last


    if @tkt1.present? && @tkt1.examen_medio.present? == true && @tkt1.examen_final.present?  == true && @tkt1.promedio >= 80
      tkt1horas = 40
    else
      tkt1horas = 0
    end
    if @tkt2.present? && @tkt2.examen_medio.present? == true && @tkt2.examen_final.present?  == true && @tkt2.promedio >= 80
      tkt2horas = 40
    else
      tkt2horas = 0
    end
    if @tkt3.present? && @tkt3.examen_medio.present? == true && @tkt3.examen_final.present?  == true && @tkt3.promedio >= 80
      tkt3horas = 40
    else
      tkt3horas = 0
    end

    @horas = tkt1horas + tkt2horas + tkt3horas

    fecha = Date.today
    @dias = fecha.day
    if fecha.month == 1
      @mes = "enero"
    elsif fecha.month == 2
      @mes = "febrero"
    elsif fecha.month == 3
      @mes = "marzo"
    elsif fecha.month == 4
      @mes = "abril"
    elsif fecha.month == 5
      @mes = "mayo"
    elsif fecha.month == 6
      @mes = "junio"
    elsif fecha.month == 7
      @mes = "julio"
    elsif fecha.month == 8
      @mes = "agosto"
    elsif fecha.month == 9
      @mes = "septiembre"
    elsif fecha.month == 10
      @mes = "octubre"
    elsif fecha.month == 11
      @mes = "noviembre"
    elsif fecha.month == 12
      @mes = "diciembre"
    end

    if fecha.year == 2017
      @anio = "dos mil diecisiete"
    elsif fecha.year == 2018
      @anio = "dos mil dieciocho"
    elsif fecha.year == 2019
      @anio = "dos mil diecinueve"
    elsif fecha.year == 2020
      @anio = "dos mil veinte"
    end

    respond_to do |format|
     format.pdf do
       render pdf: "historial_academico_#{@inscripcion_registros.nombre}_#{@inscripcion_registros.paterno}_#{@inscripcion_registros.materno}",
       disposition: "attachment",
       template: "users/historial_tkt.html.erb",
       layout: "historial_academico_ingles.html.erb",
       page_size: "Letter",
       margin: {top: 8}
     end
    end
  end

  def historiales_tkt
    @filterrific = initialize_filterrific(
    User.alumnos.order(:paterno),
    params[:filterrific],
  ) or return
  @users = @filterrific.find.page(params[:pagina])

  respond_to do |format|
    format.html
    format.js
  end

  rescue ActiveRecord::RecordNotFound => e
  # There is an issue with the persisted param_set. Reset it.
  puts "Had to reset filterrific params: #{ e.message }"
  redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def historial_tkt
  end

  def historiales
    @filterrific = initialize_filterrific(
    User.alumnos.order(:paterno),
    params[:filterrific],
    ) or return
    @users = @filterrific.find.page(params[:pagina])

    respond_to do |format|
      format.html
      format.js
    end

    rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user
      @user = User.new(user_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:nombre, :role_id, :materno, :paterno, :rfc, :centro_id, :email, :matricula, :escolaridad)
    end
end
