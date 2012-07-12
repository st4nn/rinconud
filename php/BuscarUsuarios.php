<?php 
	require("conectar.php"); 
	$link=Conectarse(); 

 $Parametro = $_POST['Parametro'];
 
 	class Usuario
	{
		public $IdUsuario;
		public $Nombre;
		public $Apellido;
		public $NickName;
		public $Correo;
		public $Entidad;
		public $Facebook;
		public $Twitter;
		public $Usuario;
		public $Estado;
	}
			$sql = "
				SELECT
					Usu.IdDatosUsuario AS 'IdUsuario',
					Usu.Nombre AS 'Nombre',
					Usu.Apellido AS 'Apellido',
					Usu.NickName AS 'NickName',
					Usu.Correo AS 'Correo',
					Ent.Nombre AS 'Entidad',
					Usu.urlFacebook AS 'Facebook',
					Usu.urlTwitter AS 'Twitter',
					Log.Usuario AS 'Usuario',
					Log.Estado As 'Estado'
				FROM
					Login AS Log,
					DatosUsuario AS Usu,
					Entidad as Ent
				WHERE
					(
						Log.IdLogin = Usu.IdDatosUsuario AND
						Usu.IdEntidad = Ent.IdEntidad 
					) AND 
					(
						Usu.Nombre LIKE '%$Parametro%' OR 
						Usu.Apellido LIKE '%$Parametro%' OR 
						Usu.NickName LIKE '%$Parametro%' OR 
						Usu.Correo LIKE '%$Parametro%' OR 
						Ent.Nombre LIKE '%$Parametro%' OR 
						Usu.urlFacebook LIKE '%$Parametro%' OR 
						Usu.urlTwitter LIKE '%$Parametro%' OR 
						Log.Usuario LIKE '%$Parametro%'
					);";		

			$result = mysql_query($sql, $link);
			$row = mysql_fetch_array($result);
		$Index = 0;
		do
		{ 
			$Usuarios[$Index] = new Usuario();
			
			$Usuarios[$Index]->IdUsuario = $row['IdUsuario'];
			$Usuarios[$Index]->Nombre = $row['Nombre'];
			$Usuarios[$Index]->Apellido = $row['Apellido'];
			$Usuarios[$Index]->NickName = $row['NickName'];
			$Usuarios[$Index]->Correo = $row['Correo'];
			$Usuarios[$Index]->Entidad = $row['Entidad'];
			$Usuarios[$Index]->Facebook = $row['Facebook'];
			$Usuarios[$Index]->Twitter = $row['Twitter'];
			$Usuarios[$Index]->Usuario = $row['Usuario'];
			$Usuarios[$Index]->Estado = $row['Estado'];

				$Index++;	
		} while($row = mysql_fetch_array($result));
		
	mysql_close($link);	
	echo json_encode($Usuarios);
?> 
