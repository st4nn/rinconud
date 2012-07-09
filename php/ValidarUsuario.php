<?php 
   include("conectar.php"); 
$User = $_POST['Usuario'];
$Pass = crypt($_POST['Clave'], 'rinconud');


class UserData
{
 var $Id;
 var $Name; 
 var $LastName; 
 var $NickName;
 var $IdCompany;
 var $CompanyName;
 var $Email;
 var $urlFacebook;
 var $urlTwitter;

 function __construct($Id, $Name, $LastName, $NickName, $IdCompany, $CompanyName, $Email, $urlFacebook, $urlTwitter)
	   {
	      $this->Id = $Id;
	      $this->Name = $Name;
	      $this->LastName = $LastName;
	      $this->NickName = $NickName;
	      $this->IdCompany = $IdCompany;
	      $this->Email = $Email;
	      $this->CompanyName = $CompanyName;
	      $this->urlFacebook = $urlFacebook;
	      $this->urlTwitter = $urlTwitter;
	   }
}
	
	$link=Conectarse(); 
	$sql = "
		SELECT 
			l.IdLogin as 'Id', 
			d.Nombre as 'Name',
			d.Apellido as 'LastName',
			d.NickName as 'NickName',
			d.IdEntidad as 'IdCompany',
			c.Nombre as 'CompanyName',
			d.Correo as 'Email',
			d.urlFacebook as 'urlFacebook',
			d.urlTwitter as 'urlTwitter'
		FROM 
			Login as l, DatosUsuario as d , Entidad as c
		WHERE
			l.IdLogin = d.IdDatosUsuario AND d.IdEntidad = c.Identidad AND 
			l.Usuario = '$User' AND l.Clave = '$Pass';";
				
	$result=mysql_query($sql, $link); 
	$row = mysql_fetch_array($result);

if ($row)
{
	$User = new UserData(  utf8_encode($row['Id']), 
							utf8_encode($row['Name']),
							utf8_encode($row['LastName']),
							utf8_encode($row['NickName']),
							utf8_encode($row['IdCompany']),
							utf8_encode($row['CompanyName']),
							utf8_encode($row['Email']),
							utf8_encode($row['urlFacebook']),
							utf8_encode($row['urlTwitter'])
							);
}else
{
	$User = new UserData('','','','','','','','','');
}
	echo json_encode($User);
	mysql_free_result($result); 
	mysql_close($link); 
?> 
