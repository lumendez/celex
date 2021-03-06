class PanelAlumnosController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: :panel_alumnos
  def index
    @inscripcion_registros = InscripcionRegistro.where("user_id = ?", current_user.id )
    @fr_inscripcion_registros = FrInscripcionRegistro.where("user_id = ?", current_user.id )
    @it_inscripcion_registros = ItInscripcionRegistro.where("user_id = ?", current_user.id )
    @examen_colocacion_idiomas = ExamenColocacionIdioma.where("user_id = ?", current_user.id )
    @cuota_ipn = CuotaCurso.find_by(descripcion: "Cuota IPN").nombre
    @cuota_externos = CuotaCurso.find_by(descripcion: "Cuota externos").nombre
  end
end
