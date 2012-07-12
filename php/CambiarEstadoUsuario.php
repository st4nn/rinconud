<?php 
   require("conectar.php"); 

	$Usuario = $_POST['IdUsuario'];	
	$Estado = $_POST['Estado'];	
	
	$link=Conectarse(); 
	$sql = "UPDATE Login
					SET Estado = '$Estado'
				WHERE
					IdLogin = '$Usuario';";
	
	mysql_query($sql, $link); 
	mysql_close($link);	
?> 
