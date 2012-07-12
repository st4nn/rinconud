<?php 
	require("conectar.php"); 
	$link=Conectarse(); 

 $Parametro = $_POST['Parametro'];
 
 	class Documento
	{
		public $IdDocumento;
		public $Titulo;
		public $Descripcion;
		public $Profesor;
		public $Carrera;
		public $Curso;
		public $Ruta;
	}
			$sql = "
				SELECT
					Doc.idDocumentoDatos AS 'IdDocumento',
					Doc.Titulo AS 'Titulo',
					Doc.Descripcion AS 'Descripcion',
					Pro.Apellido AS 'Profesor',
					Car.Nombre AS 'Carrera',
					Cur.Nombre AS 'Curso',
					Doc.url AS 'Ruta'
				FROM
					DocumentoDatos AS Doc,
					Profesores AS Pro,
					Carreras AS Car,
					Cursos AS Cur
				WHERE
					(
						Doc.Profesores_idProfesores = Pro.IdProfesores AND 
						Doc.Carreras_idCarreras = Car.idCarreras AND 
						Doc.Cursos_idCursos = Cur.idCursos
					) AND 
					(
						Doc.Titulo LIKE '%$Parametro%' OR 
						Doc.Descripcion LIKE '%$Parametro%' OR 
						Pro.Nombre LIKE '%$Parametro%' OR 
						Pro.Apellido LIKE '%$Parametro%' OR 
						Cur.Nombre LIKE '%$Parametro%' OR 
						Cur.Descripcion LIKE '%$Parametro%' OR 
						Car.Nombre LIKE '%$Parametro%' OR 
						Car.Descripcion LIKE '%$Parametro%'
					);";		

			$result = mysql_query($sql, $link);
			$row = mysql_fetch_array($result);
		$Index = 0;
		do
		{ 
			$Documentos[$Index] = new Documento();
			
			$Documentos[$Index]->IdDocumento = $row['IdDocumento'];
			$Documentos[$Index]->Titulo = $row['Titulo'];
			$Documentos[$Index]->Descripcion = $row['Descripcion'];
			$Documentos[$Index]->Profesor = $row['Profesor'];
			$Documentos[$Index]->Carrera = $row['Carrera'];
			$Documentos[$Index]->Curso = $row['Curso'];
			$Documentos[$Index]->Ruta = $row['Ruta'];

				$Index++;	
		} while($row = mysql_fetch_array($result));
		
	mysql_close($link);	
	echo json_encode($Documentos);
?> 
