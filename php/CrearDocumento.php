<?php
require("conectar.php"); 

require("VerificarCarrera.php"); 
require("VerificarCurso.php"); 
require("VerificarProfesor.php"); 

$status = "";
if ($_POST["action"] == "upload") {
    // obtenemos los datos del archivo
    $tamano = $_FILES["archivo"]['size'];
    $tipo = $_FILES["archivo"]['type'];
    $archivo = $_FILES["archivo"]['name'];
    $prefijo = substr(md5(uniqid(rand())),0,6);
   
    if ($archivo != "") {
		
		$Titulo = $_POST['Titulo'];
		$Descripcion = $_POST['Descripcion'];
		$ProfesorNombre = $_POST['ProfesorNombre'];
		$ProfesorApellido = $_POST['ProfesorApellido'];
		$ProfesorId = VerificarProfesor($ProfesorNombre, $ProfesorApellido);
		$CarreraId = VerificarCarrera($_POST['Carrera']);
		$CursoId = VerificarCurso($_POST['Curso']);
		
        // guardamos el archivo a la carpeta files
        $destino =  "../Documentos/".$prefijo."_".$archivo;
        if (copy($_FILES['archivo']['tmp_name'],$destino)) {
            $status = "Archivo subido: <b>".$archivo."</b>";
            $NombreArchivo = $prefijo."_".$archivo;
            
            $link=Conectarse(); 
            $sql = "INSERT INTO DocumentoDatos 
								(
								Titulo,
								Descripcion,
								Profesores_idProfesores,
								Carreras_idCarreras,
								Cursos_idCursos,
								url)
							VALUES
								(
									'$Titulo',	
									'$Descripcion',
									'$ProfesorId',
									'$CarreraId',
									'$CursoId',
									'$NombreArchivo'
								)";
            mysql_query($sql, $link); 
            $DocumentoId = mysql_insert_id();
            $UsuarioId = $_POST['txtUsuarioId'];
            
            $Fecha = date('Y-m-d'); 
            
            $sql = "INSERT INTO Login_has_Documentos
								(Login_IdLogin, Documentos_idDocumento, Fecha)
							VALUES (
										'$UsuarioId',
										'$DocumentoId',
										'$Fecha'
								   );";
            mysql_query($sql, $link); 
        } else {
            $status = "Error al subir el archivo";
        }
    } else {
        $status = "Error al subir archivo";
    }
    Header ("Location: ../index.html");
}
?>
