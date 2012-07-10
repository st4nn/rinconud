<?php 
function VerificarCarrera($Carrera)
{
	$link=Conectarse(); 
	$var = null;
	$sql = "SELECT idCarreras FROM Carreras WHERE Nombre = '$Carrera';";
	$result=mysql_query($sql, $link); 
	$row = mysql_fetch_array($result);
	if ($row['idCarreras'])
	{
		$var = $row['idCarreras'];
	} 
	else
	{
		$CarreraDescripcion = $_POST['CarreraDescripcion'];
		$sql = "INSERT INTO Carreras (Nombre, Descripcion) 
					VALUES ('$Carrera', '$CarreraDescripcion')";
		$result=mysql_query($sql, $link); 
		$var = mysql_insert_id();	
	}
	return $var;
	mysql_close($link);	
}	
?> 
