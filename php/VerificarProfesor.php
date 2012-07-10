<?php 
function VerificarProfesor($Nombre, $Apellido)
{
	$link=Conectarse(); 
	$var = null;
	$sql = "SELECT idProfesores FROM Profesores WHERE Nombre = '$Nombre' AND Apellido ='$Apellido';";
	$result=mysql_query($sql, $link); 
	$row = mysql_fetch_array($result);
	if ($row['idProfesores'])
	{
		$var = $row['idProfesores'];
	} 
	else
	{
		$sql = "INSERT INTO Profesores (Nombre, Apellido) 
					VALUES ('$Nombre', '$Apellido')";
		$result=mysql_query($sql, $link); 
		$var = mysql_insert_id();	
	}
	return $var;
	mysql_close($link);	
}	
?> 
