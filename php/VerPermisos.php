<?php 
   require("conectar.php"); 
	$link=Conectarse(); 
	
	$Id = $_POST['Id'];
	
	$sql = "SELECT
				p.IdPermiso AS 'IdPermission',
				p.IdFuncion AS 'IdFunction',
				f.Nombre AS 'Name',
				f.Descripcion AS 'Description',
				f.ControlAsociado AS 'AssociatedControl'
			FROM
				Permisos AS p,
				Funciones AS f
			WHERE
				p.IdFuncion = f.IdFuncion AND
				p.IdLogin = '$Id';";
    
    
	$result = mysql_query($sql, $link);
	$row = mysql_fetch_array($result);
	
		class Permissions
	{
		public $IdPermission;
		public $IdFunction;
		public $Name;
		public $Description;
		public $AssociatedControl;
	}
	$Index = 0;
	do 
	{ 
		$Permission[$Index] = new Permissions();
		
		$Permission[$Index]->IdPermission = $row['IdPermission'];
		$Permission[$Index]->IdFunction = $row['IdFunction'];
		$Permission[$Index]->Name = $row['Name'];
		$Permission[$Index]->Description = $row['Description'];
		$Permission[$Index]->AssociatedControl = $row['AssociatedControl'];

		$Index++;
	} while($row = mysql_fetch_array($result));

	mysql_close($link);	
	echo json_encode($Permission);
?> 
