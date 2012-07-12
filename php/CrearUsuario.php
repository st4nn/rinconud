<?php 
	require("VerificarEntidad.php"); 

 $Id = $_POST['Id'];
 
 $User = $_POST['User'];
 $Password = crypt($_POST['Password'], 'rinconud');
 
 $Name = $_POST['Name']; 
 $LastName = $_POST['LastName']; 
 $NickName = $_POST['NickName'];
 $Email = $_POST['Email'];
 $Company = $_POST['Company'];
 $urlFacebook = $_POST['urlFacebook'];
 $urlTwitter = $_POST['urlTwitter'];
 
 
$CompanyId = CompanyVerify($Company); //Verfica que el nombre de la Compañía exista en la Base de Datos
	if (!$CompanyId)			
	{
		echo "Entidad no encontrada";		//Si no existe no crea el Usuario y debe crear la Compañía en el fómulario de Crear Usuario
	}else
	{
		$link=Conectarse(); 
		$sql = "INSERT INTO DatosUsuario
						(Nombre, Apellido, NickName, Correo, IdEntidad, urlFacebook, urlTwitter)
					VALUES
						(
						'$Name', 
						'$LastName', 
						'$NickName', 
						'$Email', 
						'$CompanyId', 
						'$urlFacebook', 
						'$urlTwitter');";		
						
		$result = mysql_query($sql, $link); 			
		$UserId = mysql_insert_id();	
	
		if ($result)
		{
			$sql = "
			INSERT INTO Login 
				(IdLogin, Usuario, Clave, Estado)
			VALUES
				(
			'$UserId', 
			'$User',   
			'$Password',
			'Activo'
				);";		

			mysql_query($sql, $link);
			echo $UserId;
			
		} else
		{
				if (mysql_errno() == 1062)
				{
					echo "El Usuario ya Existe";
				} else
				{
					echo "El Usuario NO ha sido creado";	
				}
		}
	}
		mysql_close($link); 
?> 
