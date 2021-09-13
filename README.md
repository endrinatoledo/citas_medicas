# ******** Citas Medicas


# end points
    http://localhost/citas_medicas/medicalAppointments

#  --- Citas medicas por idRol
  --- --- Metodo GET
  --- --- --- Rol de medico 2
  --- --- --- Rol de Paciente 1
    http://localhost/citas_medicas/medicalAppointments?idRol=2


#  --- Agregar cita con rol Paciente
  --- --- Metodo POST
  --- --- --- Id del paciente 1 - idPatient
  --- --- --- Id del Doctor 1 - idPatient
  --- --- --- Rol de Paciente 1 - idRol
  --- --- --- Estatus de cita aceptado 1 - statusAppointment
            {"idPatient":"1", "idDoctor":"1" ,"date":"2021-09-14","idRol":"1"}

#  --- Cambiar estatus de cita
  --- --- Metodo PUT
  --- --- --- Rol de medico 2 - idRol
  --- --- --- Estatus de cita rechazo 0 - statusAppointment
  --- --- --- Estatus de cita aceptado 1 - statusAppointment
  --- --- --- Id de cita medica 1 - idAppointment

            {"statusAppointment":"1", "idAppointment":"2" ,"idRol":"2"}

    

    

