<?php 
   require("conectar.php"); 

	$Name = $_POST['Name'];	
	$Url = $_POST['Url']; 
	$Description = $_POST['Description']; 

	$link=Conectarse(); 
	$sql = "INSERT INTO Entidad
					(Nombre, url, Descripcion)
				VALUES
					(
					'$Name', 
					'$Url', 
					'$Description');";
	
	mysql_query($sql, $link); 
	$CompanyId = mysql_insert_id();
	
	echo $CompanyId;
	mysql_close($link);	
	
?> 
