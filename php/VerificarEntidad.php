<?php 
   require("conectar.php"); 

$NoFName = $_POST['NoFName'];

function CompanyVerify($Name)
{
	$link=Conectarse(); 
	$var = null;
	$sql = "SELECT IdEntidad FROM Entidad WHERE Nombre = '$Name';";
	$result=mysql_query($sql, $link); 
	$row = mysql_fetch_array($result);
	if ($row['IdEntidad'])
	{
		$var = $row['IdEntidad'];
	} 
	return $var;
	mysql_close($link);	
}
	if ($NoFName)
	{echo CompanyVerify($NoFName);}
?> 
