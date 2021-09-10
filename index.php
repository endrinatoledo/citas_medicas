<?php

require_once "config/conexion.php";


$conexion = new conexion;


$query= 'SELECT 
us.id as idUsu,
us.nombre as nomUsu,
us.apellido as apeUsu,
us.email as emaUsu,
us.status as staUsu,
me.id as idMed,
me.id_usurol as idUsr,
me.id_esp as idEsp,
es.nombre as nomEsp
FROM medicos as me 
INNER JOIN especialidades as es ON me.id_esp = es.id
INNER JOIN usu_rol as ur ON me.id_usurol = ur.id
INNER JOIN usuarios as us ON ur.id_usu = us.id
WHERE me.status = 1';

print_r($conexion->obtenercitas($query));

?>