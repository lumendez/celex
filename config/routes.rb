Rails.application.routes.draw do

  get 'panel_instructor_diplomados', to: 'panel_instructor_diplomados#index'
  get 'calificacion_diplomados', to: 'panel_instructor_diplomados#calificacion_diplomados'

  resources :calificacion_modulos do
    collection do
      patch 'actualizar_calificaciones'
    end
  end
  resources :grupos_diplomados do
    collection do
      get 'acta/:id', to: 'grupos_diplomados#acta', as: 'acta'
      get 'lista_dec/:id', to: 'grupos_diplomados#lista_dec', as: 'lista_dec'
      get 'lista_cec/:id', to: 'grupos_diplomados#lista_cec', as: 'lista_cec'
      get 'expedicion_diplomas/:id', to: 'grupos_diplomados#expedicion_diplomas', as: 'expedicion_diplomas'
    end
  end
  resources :buscar_cartas do
    collection do
      get :carta
    end
  end

  resources :grupos_unitarios do
    collection do
      get 'grupo_excel/:id', to: 'grupos_unitarios#grupo_excel', as: 'grupo_excel'
      get 'grupo_correo/:id', to: 'grupos_unitarios#grupo_correo', as: 'grupo_correo'
    end
  end
  resources :unitarios do
    collection do
      get 'asignar_calificaciones'
      patch 'actualizar_asignar_calificaciones'
      get 'editar_datos'
      patch 'actualizar_editar_datos'
      get 'asignar_grupos_nms_s'
      get 'grupos_nms_s'
      patch 'actualizar_grupos_nms_s'
      get '/credenciales_media/:id', to: 'unitarios#credenciales_media', as: 'credenciales_media'
      get '/carta_compromiso/:id', to: 'unitarios#carta_compromiso', as: 'carta_compromiso'
      get 'reporte_dems'
      get 'reporte_no_validados'
      get 'reporte_contactos'
      get 'generar_credenciales'
      get 'imprimir_credenciales_media'
      get 'imprimir_credenciales_superior'
      get 'imprimir_credenciales_media_grupo'
      get 'imprimir_credenciales_superior_grupo'
    end
  end
  resources :anexos_unicos_examen do
    collection do
      get 'index'
      get 'imprimir_anexo_unico'
    end
  end
  resources :seccion_nombres
  resources :anexos_unicos do
    collection do
      get 'index'
      get 'imprimir_anexo_unico'
    end
  end
  resources :it_inscripcion_registros do
    collection do
      post 'habilitar_multiples_constancias'
      patch 'actualizar_multiples_constancias'
      get 'ver_constancias'
      get 'constancia/:id', to: 'inscripcion_registros#constancia',  as: 'constancia'
      post 'imprimir'
      post 'asignar_calificaciones'
      patch 'actualizar_asignar_calificaciones'
      get 'reporte_curso'
      get 'reporte_dec'
      get 'editar_datos'
      patch 'actualizar_editar_datos'
      get '/talon/:id', to: 'it_inscripcion_registros#talon', as: 'talon'
      get 'caso_especial'
      post 'guardar_caso_especial'
    end
  end
  resources :fr_inscripcion_registros do
    collection do
      post 'habilitar_multiples_constancias'
      patch 'actualizar_multiples_constancias'
      get 'ver_constancias'
      get 'constancia/:id', to: 'inscripcion_registros#constancia',  as: 'constancia'
      post 'imprimir'
      post 'asignar_calificaciones'
      patch 'actualizar_asignar_calificaciones'
      get 'reporte_curso'
      get 'reporte_dec'
      get 'editar_datos'
      patch 'actualizar_editar_datos'
      get '/talon/:id', to: 'fr_inscripcion_registros#talon', as: 'talon'
      get 'caso_especial'
      post 'guardar_caso_especial'
    end
  end
  resources :curriculums
  resources :registro_cursos
  resources :examen_colocacion_idiomas
  resources :constancia
  resources :historial_carta
  resources :grupo_datos
  resources :datos_bancos
  resources :numero_registros
  resources :proyectos
  resources :clave_catalogos
  resources :cuota_cursos
  resources :modalidad_oferta
  resources :tipo_oferta
  resources :centros
  resources :materia
  resources :lugar_nombres
  devise_for :users, :controllers => { registrations: 'registrations' }
  scope "/admin" do
    resources :users
  end
  resources :roles
  resources :users do
    collection do
      get 'instructores'
      get 'historiales_ingles'
      get 'historial_ingles/:id', to: 'users#historial_ingles', as: 'historial_ingles'
      get 'anexos_unicos/:id', to: 'users#anexos_unicos', as: 'anexos_unicos'
      get 'conclusion_eventos', to: 'users#conclusion_eventos', as: 'conclusion_eventos'
      get 'datos_anexo_unico'
      get 'generar_anexo_unico'
      get 'historial_academico_ingles/:id', to: 'users#historial_academico_ingles', as: 'historial_academico_ingles'
      get 'historiales_frances'
      get 'historial_frances/:id', to: 'users#historial_frances', as: 'historial_frances'
      get 'historial_academico_frances/:id', to: 'users#historial_academico_frances', as: 'historial_academico_frances'
      get 'historiales_italiano'
      get 'historial_italiano/:id', to: 'users#historial_italiano', as: 'historial_italiano'
      get 'historial_academico_italiano/:id', to: 'users#historial_academico_italiano', as: 'historial_academico_italiano'
      get 'historiales_b2'
      get 'historial_b2/:id', to: 'users#historial_b2', as: 'historial_b2'
      get 'historial_academico_b2/:id', to: 'users#historial_academico_b2', as: 'historial_academico_b2'
      get 'historiales_tkt'
      get 'historial_tkt/:id', to: 'users#historial_tkt', as: 'historial_tkt'
      get 'historial_academico_tkt/:id', to: 'users#historial_academico_tkt', as: 'historial_academico_tkt'
      get 'historiales'
    end
  end
  resources :estados
  resources :grupos do
    collection do
      post 'edit_multiple'
      patch 'update_multiple'
      get 'crear_constancias/:id', to: 'grupos#crear_constancias',  as: 'crear_constancias'
      get 'calificaciones/:id', to: 'grupos#calificaciones', as: 'calificaciones'
      get 'apertura/:id', to: 'grupos#apertura', as: 'apertura'
      get 'lista_asistencia/:id', to: 'grupos#lista_asistencia', as: 'lista_asistencia'
      get 'supervisar/:id', to: 'grupos#supervisar', as: 'supervisar'
    end
  end
  #resources :profesor_nombres
  resources :generos
  resources :curso_nombres
  resources :calendarios
  resources :procedencia
  resources :cuota
  resources :nivel_nombres
  resources :idiomas
  resources :horarios
  resources :inscripcion_registros do
    collection do
      post 'habilitar_multiples_constancias'
      patch 'actualizar_multiples_constancias'
      get 'ver_constancias'
      get 'constancia/:id', to: 'inscripcion_registros#constancia',  as: 'constancia'
      post 'imprimir'
      get 'asignar_calificaciones'
      patch 'actualizar_asignar_calificaciones'
      get 'reporte_curso'
      get 'reporte_dec_frances'
      get 'reporte_dec_italiano'
      get 'reporte_dec'
      get 'editar_datos'
      patch 'actualizar_editar_datos'
      get 'caso_especial'
      post 'guardar_caso_especial'
      get 'certificacion'
      get '/talon/:id', to: 'inscripcion_registros#talon', as: 'talon'
      get '/constancia_avanzado/:id', to: 'inscripcion_registros#constancia_avanzado', as: 'constancia_avanzado'
      get 'ver_constancias_tkt'
      get '/constancia_tkt/:id', to: 'inscripcion_registros#constancia_tkt', as: 'constancia_tkt'
      get 'ver_constancias_b2'
      get '/constancia_b2/:id', to: 'inscripcion_registros#constancia_b2', as: 'constancia_b2'
    end
  end
  resources :panel_alumnos do
    collection do
      get 'facturacion'
      get 'regulaciones'
    end
  end
  resources :panel_profesores do
    collection do
      get 'mis_grupos'
      get 'historial_academico'
    end
  end
  get '/panel_control_escolar/', to: 'panel_control_escolar#index'

  resources :reinscripcion_registros do
    collection do
      get :boleta
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #devise_scope :user do
    #root to: "devise/sessions#new"
  #end
  root to: "inicio#index"
end
