<?php

require_once "class/medicalAppointments.class.php";
require_once "class/responses.class.php";

$_medicalAppointments = new medicalAppointments;
$_responses = new responses;


if($_SERVER['REQUEST_METHOD'] == "GET"){
    if(isset($_GET['idRol'])){
        
         $idAppointment = $_GET['idRol'];
         $dataAppointment = $_medicalAppointments->AppointmentListById($idAppointment);
         header("Content-Type: application/json");
         echo json_encode($dataAppointment);
         http_response_code(200);
    }

    
}else if($_SERVER['REQUEST_METHOD'] == "POST"){

    //recibimos los datos enviados
    $postBody = file_get_contents("php://input");
    //enviamos los datos al manejador
    $datosArray = $_medicalAppointments->createAppointment($postBody);
    //delvovemos una respuesta 
    header('Content-Type: application/json');
    if(isset($datosArray["result"]["error_id"])){
        $responseCode = $datosArray["result"]["error_id"];
        http_response_code($responseCode);
    }else{
        http_response_code(200);
    }
    echo json_encode($datosArray);

}else if($_SERVER['REQUEST_METHOD'] == "PUT"){

    //recibimos los datos enviados
    $postBody = file_get_contents("php://input");
    //enviamos datos al manejador
    $datosArray = $_medicalAppointments->updateAppointmentStatus($postBody);
      //delvovemos una respuesta 
   header('Content-Type: application/json');
   if(isset($datosArray["result"]["error_id"])){
       $responseCode = $datosArray["result"]["error_id"];
       http_response_code($responseCode);
   }else{
       http_response_code(200);
   }
   echo json_encode($datosArray);
    
}else{
    header('Content-Type: application/json');
    $datosArray = $_responses->error_405();
    echo json_encode($datosArray);

}

?>