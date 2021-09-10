<?php


require_once "config/conexion.php";
require_once "responses.class.php";



class medicalAppointments extends conexion{

    private $medical_appointments = "medical_appointments";
    private $doctors = "doctors";
    private $specialties = "specialties";
    private $patients = "patients";
    private $idPatient;
    private $idDoctor;
    private $date;
    private $statusAppointment;
    private $idAppointment;
    


   public function AppointmentList($page){

    $initiation = 0;
    $amount = 100;

    if($page > 1){
        $initiation = ($amount * ($page - 1)) +1 ;
        $amount = $amount * $page;
    }

    $query = "SELECT 
    me.map_id as idAppointments,
    me.map_date as dateAppointments,
    me.map_status as statusAppointments,
    do.doc_id as idDoctor,
    do.doc_first_name as firstNameDoctor,
    do.doc_last_name as lastNameDoctor,
    es.spe_name as specialtyName,
    pa.pat_id as idPatient,
    pa.pat_first_name as firstNamePatiente,
    pa.pat_last_name as lastNamePatiente
    FROM " . $this->medical_appointments . " as me
    INNER JOIN " . $this->doctors . "  as do on do.doc_id = me.doc_id
    INNER JOIN " . $this->specialties . " as es on es.spe_id = do.spe_id
    INNER JOIN " . $this->patients . " as pa on pa.pat_id = me.pat_id";

    // $query = "SELECT * FROM " . $this->medical_appointments . " limit $initiation,$amount";
    $data = parent::getInformation($query);
    return ($data);

   }

   public function AppointmentListById($idRol){
       if($idRol == 2){
            $query = "SELECT 
            me.map_id as idAppointments,
            me.map_date as dateAppointments,
            me.map_status as statusAppointments,
            do.doc_id as idDoctor,
            do.doc_first_name as firstNameDoctor,
            do.doc_last_name as lastNameDoctor,
            es.spe_name as specialtyName,
            pa.pat_id as idPatient,
            pa.pat_first_name as firstNamePatiente,
            pa.pat_last_name as lastNamePatiente
            FROM " . $this->medical_appointments . " as me
            INNER JOIN " . $this->doctors . "  as do on do.doc_id = me.doc_id
            INNER JOIN " . $this->specialties . " as es on es.spe_id = do.spe_id
            INNER JOIN " . $this->patients . " as pa on pa.pat_id = me.pat_id  WHERE map_date = CURDATE()";
            return parent::getInformation($query);
       }else{
        $_responses = new responses;
        return $_responses->error_200('No posee el rol para visualizar listado de citas');
       }
    
}


public function createAppointment($json){
    $_responses = new responses;
    $data = json_decode($json,true);

    if($data['idRol'] == 1){

        if(!isset($data['idPatient']) || !isset($data['idDoctor']) || !isset($data['date'])){
            return $_responses->error_400();
        }else{
            $this->idPatient = $data['idPatient'];
            $this->idDoctor = $data['idDoctor'];
            $this->date = $data['date'];
            if(isset($data['idPatient'])) { $this->idPatient = $data['idPatient']; }
            if(isset($data['idDoctor'])) { $this->idDoctor = $data['idDoctor']; }
            if(isset($data['date'])) { $this->date = $data['date']; }
            $resp = $this->insertAppointment();
            if($resp){
                $respuesta = $_responses->response;
                $respuesta["result"] = array(
                    "IdAppointment" => $resp
                );
                return $respuesta;
            }else{
                return $_responses->error_500();
            }
        }

    }else{
        return $_responses->error_200('No posee el rol para generar cita');
    }
    
}


private function insertAppointment(){
    $query = "INSERT INTO " . $this->medical_appointments . " (`pat_id`, `doc_id`, `map_date`)
    values
    ('" . $this->idPatient . "','" . $this->idDoctor . "','" . $this->date ."')"; 
    $resp = parent::nonQueryId($query);
    if($resp){
         return $resp;
    }else{
        return 0;
    }
}

private function update_status_Appointment(){
    $query = "UPDATE " . $this->medical_appointments . " SET map_status='" . $this->statusAppointment . "' WHERE map_id = " . $this->idAppointment . ";";    
    $resp = parent::nonQuery($query);

    echo $resp;

        if($resp >= 1){
             return $resp;
        }else{
            return 0;
        }
}



public function updateAppointmentStatus($json){
    $_responses = new responses;
    $data = json_decode($json,true);

    if($data['idRol'] == 2){

        if(!isset($data['statusAppointment']) || !isset($data['idAppointment'])){
            return $_responses->error_400();
        }else{

            if(($data['statusAppointment'] != 1) && ($data['statusAppointment'] != 0)){
                return $_responses->error_200('Estatus no permitido');
            }else{

            

            $this->statusAppointment = $data['statusAppointment'];
            $this->idAppointment = $data['idAppointment'];
            
            if(isset($data['statusAppointment'])) { $this->statusAppointment = $data['statusAppointment']; }
            if(isset($data['idAppointment'])) { $this->idAppointment = $data['idAppointment']; }            
            $resp = $this->update_status_Appointment();
            if($resp){
                $respuesta = $_responses->response;
                $respuesta["result"] = array(
                    "idAppointment" => $this->idAppointment
                );
                return $respuesta;
            }else{
                return $_responses->error_500();
            }
        }
        }

    }else{
        return $_responses->error_200('No posee el rol para actualizar cita');
    }
    
}

}



?>