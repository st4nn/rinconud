<?php 
function VerificarCurso($Curso)
{
	$link=Conectarse(); 
	$var = null;
	$sql = "SELECT idCursos FROM Cursos WHERE Nombre = '$Curso';";
	$result=mysql_query($sql, $link); 
	$row = mysql_fetch_array($result);
	if ($row['idCursos'])
	{
		$var = $row['idCursos'];
	} 
	else
	{
		$CursoDescripcion = $_POST['CursoDescripcion'];
		$sql = "INSERT INTO Cursos (Nombre, Descripcion) 
					VALUES ('$Curso', '$CursoDescripcion')";
		$result=mysql_query($sql, $link); 
		$var = mysql_insert_id();	
	}
	return $var;
	mysql_close($link);	
}	
?> 
