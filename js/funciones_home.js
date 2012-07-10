var Usuario;
$(document).on("ready", arranque);


function arranque()
{
	
	
	$("#btnBuscarDocumento").on("click", function()
										{
											$("#frmCuerpo form").slideUp();
											$("#frmBuscarDocumento").slideDown();
										}
							);
	$("#btnCerrarSesion").on("click", btnCerrarSesion_Click);
	
	$("#btnCrearUsuario").on("click", function()
										{
											$("#frmCuerpo form").slideUp();
											$("#frmCreatingUsersCreate").slideDown();
										}
							);
	
	$("#btnCompanyDataCancel").on("click", btnCompanyDataCancel_click);
	$("#btnCompanyDataCreate").on("click", btnCompanyDataCreate_click);
	$("#btnIniciarSesion").on("click", btnIniciarSesion_Click);
	$("#btnSubirArchivo").on('click', function()
										{
											$("#frmCuerpo form").slideUp();
											$("#txtUsuarioId").val(Usuario.Id);
											$("#frmCreandoDocumentos").slideDown();
										}
							);
	$("#btnVerDocumento").live('click', function()
										{
											
											window.open("Documentos/" + $(this).attr('Ruta'));
										});
	
	$("#CreatingUsersCreate").on('submit', CrearUsuario);
	$("#frmBuscarDocumento").on('submit', frmBuscarDocumento_Submit);
	
	$("#frmCreandoDocumentos").on('submit', frmCreandoDocumentos_Submit);
	
	
	$("#txtCreatingUsersCreate_Company").live("change", VerificarEntidad);
	CargarUsuario();
}
function btnCerrarSesion_Click()
{
	delete localStorage.Usuario;
	window.location.reload();
}
function btnCompanyDataCancel_click(evento)
{
	evento.preventDefault();
	$("#CompanyData").slideUp();
	$("#txtCreatingUsersCreate_Facebook").focus();	
}
function btnCompanyDataCreate_click(evento)
{
	evento.preventDefault();
		$.post("php/CrearEntidad.php",  
		{
			Name: $("#txtCreatingUsersCreate_Company").val(),
			Url: $("#txtCreatingUsersCreate_CompanyUrl").val(),
			Description: $("#txtCreatingUsersCreate_CompanyDescription").val()
		}, 
		function(data)
		{	
			data = parseInt(data);
			if (isNaN(data)) 
			{ 
				MostrarAlerta("CreatingUsers_Create", "error", "ui-icon-alert", "Error!", "La entidad NO fué creada");
			}
			else
			{ 
				MostrarAlerta("CreatingUsers_Create", "default", "ui-icon-circle-check", "Hey!", "La Entidad ha sido creada");
				btnCompanyDataCancel_click(evento)
			} 
		});		
}
function btnIniciarSesion_Click()
{
	ResetearContenedor("frmIniciarSesion");
	$("#frmIniciarSesion").dialog(
			{
		autoOpen: false, 	
		dialogClass: "alert",	
		buttons: [
					{
						text: "Ingresar",
						click: function()
									{
										IniciarSesion();
									}
					},
					{
						text: "Cancelar",
						click: function()
									{
										$(this).dialog("close");
									}
					}
				],
		minWidth: 620,
		modal: true,
		show: "slide",
		title : 'Iniciar Sesión'
			});
			$("#frmIniciarSesion").dialog('open');
}

function CargarPermisos(IdUsuario)
{
	$.post("php/VerPermisos.php",
		{ Id : IdUsuario},
		function(data){
			$("#TableFunctions td").remove();
			$.each(data,function(index,value) 
			{
				if (data[index].IdPermission)
				{
					$("#" + data[index].AssociatedControl).slideDown();
				}
			});
					},
		"json");
}
function CargarUsuario()
{
	if(localStorage.Usuario)
	{
		Usuario = JSON.parse(localStorage.Usuario)[0];
		$("#lblWelcome span").text(Usuario.NickName);
		CargarPermisos(Usuario.Id);
		$("#btnIniciarSesion").slideUp();
		if(localStorage.Documento)
		{
			var Documento = JSON.parse(localStorage.Documento)[0];
			$("#frmCuerpo form").slideUp();
				$("#txtUsuarioId").val(Usuario.Id);
				$("#frmCreandoDocumentos").slideDown();
			MostrarAlerta("CreandoDocumentos_Crear", "default", "ui-icon-circle-check", "Hey!", "El Documento: " + Documento.Titulo + " ha sido creado");
			delete localStorage.Documento;
		}
	}else
	{
		$("#botones button").slideUp();
		$("#btnIniciarSesion").slideDown();
	}
}
function CrearUsuario(evento)
{
	evento.preventDefault();
	if ($("#txtCreatingUsersCreate_Password").val() == $("#txtCreatingUsersCreate_ReTypePassword").val())
	{
		$.post("php/CrearUsuario.php",  
		{
			Id: Usuario.Id,
			User: $("#txtCreatingUsersCreate_User").val(),
			Password: $("#txtCreatingUsersCreate_Password").val(),
			Name: $("#txtCreatingUsersCreate_Name").val(),
			LastName: $("#txtCreatingUsersCreate_LastName").val(),
			NickName: $("#txtCreatingUsersCreate_DisplayName").val(),
			Email: $("#txtCreatingUsersCreate_Email").val(),
			Company: $("#txtCreatingUsersCreate_Company").val(),
			urlFacebook: $("#txtCreatingUsersCreate_Facebook").val(),
			urlTwitter: $("#txtCreatingUsersCreate_Twitter").val(),
			NoFName: "false"
		}, 
		function(data)
		{
			var Id = parseInt(data);
			if (isNaN(Id)) //No lo Creó
			{ 
				MostrarAlerta("CreatingUsers_Create", "error", "ui-icon-alert", "Alert!", data);
			}
			else //Si lo Creó
			{ 
				EditarPermisos(Id);
				MostrarAlerta("CreatingUsers_Create", "default", "ui-icon-circle-check", "Hey!", "El Usuario ha sido creado");
				ResetearContenedor("CreatingUsersCreate");
			} 
		});	
	} else
	{
		MostrarAlerta("CreatingUsers_Create", "error", "ui-icon-alert", "Error!", "Las Claves deben ser iguales");
	}
}
function EditarPermisos(IdUsuario)
{
$.post("php/VerPermisos.php",
		{ Id : Usuario.Id},
		function(data){
			$("#UserTableFunctions td").remove();
			$.each(data,function(index,value) 
			{
				if (data[index].IdPermission)
				{
					var tds = "<tr id='" + data[index].IdPermission + "'>";
						  tds += "<td name='" + data[index].IdPermission + "'><input name='chkPermissionState' type='checkbox' id='chk" + data[index].IdFunction + "' AssociatedControl='" + data[index].AssociatedControl + "' IdFunction='" + data[index].IdFunction + "'/></td>";
						  tds += "<td name='" + data[index].IdPermission + "'>" + data[index].Name + "</td>";
						  tds += "<td name='" + data[index].IdPermission + "'>" + data[index].Description + "</td>";
						  tds += "<td name='" + data[index].IdPermission + "' IdFunction='" + data[index].IdFunction + "'></td>";
						tds += '</tr>';	
					$("#UserTableFunctions").append(tds);
				}
			});
			$.post("php/VerPermisos.php",
								{ Id : IdUsuario},
								function(data2)
								{
									$.each(data2,function(index2,value2)
									{
										$("#chk" + data2[index2].IdFunction).attr("checked", "checked");
									});
								}, "json");
					},
		"json");
		
		$("#MyUsersEdit_Permissions").dialog({
		autoOpen: false, 
		minWidth: 620,
		title: "Editar Permisos",
		buttons: [
			{
				text: "Ok",
				click: function() { 
									var tabla = document.getElementById("UserTableFunctions");
									var numFilas = tabla.rows.length;
									var Controles = "";
									var elementos = tabla.getElementsByTagName("input")
									for (i = 0; i < numFilas; i++)
									{
										if($(elementos[i]).is(':checked'))
										{
											Controles += $(elementos[i]).attr("IdFunction") + "@";
										}
									}
									$.post("php/EditarPermiso.php",
											{Functions: Controles, IdUser: IdUsuario},
											function(data)
											{
												if (parseInt(data) > 0)
												{
													$("#MyUsersEdit_Permissions").dialog("close"); 
												}
											}
										  );
								  }
			},
			{
				text: "Cancel",
				click: function() { $(this).dialog("close"); 
								  }
			}
				  ]
								});
	$("#MyUsersEdit_Permissions").dialog('open');	
	
	$.post('php/CargarRoles.php',
		{Id_Roll : Usuario.IdInitialRoll},
		function(data)
		   {
				$("#MyUsersEdit_Permissions_Roll").html(data);
		   }, "html"	
		);
}
function frmBuscarDocumento_Submit(evento)
{
	evento.preventDefault();
	$.post("php/BuscarDocumento.php",
		{ Parametro : $("#txtBuscarDocumento").val()},
		function(data){
			$("#TablaDocumentos td").remove();
			$.each(data,function(index,value) 
			{
				if (data[index].IdDocumento)
				{
					var tds = "<tr id='" + data[index].IdDocumento + "'>";
						  tds += "<td name='" + data[index].IdDocumento + "'>" + data[index].Titulo + "</td>";
							tds += "<td name='" + data[index].IdDocumento + "'>" + data[index].Descripcion + "</td>";
							tds += "<td name='" + data[index].IdDocumento + "'>" + data[index].Profesor + "</td>";
							tds += "<td name='" + data[index].IdDocumento + "'>" + data[index].Carrera + "</td>";
							tds += "<td name='" + data[index].IdDocumento + "'>" + data[index].Curso + "</td>";
							tds += "<td name='" + data[index].IdDocumento + "'>" + "<button title='Ver Documento' id='btnVerDocumento' ruta ='" + data[index].Ruta + "' class='ui-button-default ui-button ui-widget ui-corner-all'><strong><span class='ui-icon ui-icon-document'></span></strong></button>" + "</td>";
						  
						tds += '</tr>';	
					$("#TablaDocumentos").append(tds);
				}
			});
				}, "json");
			
}
function frmCreandoDocumentos_Submit()
{
	var Documento = {
    "Titulo" : $("#txtCreandoDocumentos_Titulo").val(),
    "Descripcion" : $("#txtCreandoDocumentos_Descripcion").val(),
    "ProfesorNombre" : $("#txtCreandoDocumentos_ProfesorNombre").val(),
    "ProfesorApellido" : $("#txtCreandoDocumentos_ProfesorApellido").val(),
    "CarreraNombre" : $("#txtCreandoDocumentos_Carrera").val(),
	"CursoNombre" : $("#txtCreandoDocumentos_Curso").val()
	};
	localStorage.setItem("Documento", '[' + JSON.stringify(Documento) + ']');	
}
function IniciarSesion()
{	
	$.post("php/ValidarUsuario.php",  
	{
		Usuario: $("#txtUsername").val(), 
		Clave: $("#txtPassword").val()
	}, 
	function(data)
	{	
		if (data.Id)
		{
			localStorage.setItem("Usuario", '[' + JSON.stringify(data) + ']');			
			window.location.reload()
		}
		else
		{
			$("#alertEstadoLogin").fadeIn(200).delay(1600).fadeOut(1200);
		}
	}, 
	"json");
}
function MostrarAlerta(NombreContenedor, TipoMensaje, Icono, Strong, Mensaje)
{
	/*NombreContenedor : Id del Div que contiene el MessageAlert
	 * TipoMensaje : {highlight, error, default}
	 * Icono : Icono que acompaña el mensaje ver listado en bootstrap
	 * Mensaje del AlertMessage*/
	 
	$("#" + NombreContenedor).removeClass(function() {return $(this).prev().attr('class');});
	$("#" + NombreContenedor + " span").removeClass("*");
	$("#" + NombreContenedor).addClass("ui-state-" + TipoMensaje);
	$("#" + NombreContenedor + " span").addClass(Icono);
	$("#" + NombreContenedor + " strong").text(Strong);
	$("#" + NombreContenedor + " texto").text(Mensaje);
	$("#" + NombreContenedor).fadeIn(300).delay(2600).fadeOut(600);
}
function ResetearContenedor(IdContenedor)
{
		  $('#' + IdContenedor).find(':input').each(function() {
			if ($(this).attr('type') != 'submit')
			  {
                $(this).val('');
              }
			});
}
function VerificarEntidad(evento)
{
	$.post("php/VerificarEntidad.php",  
	{
		NoFName: $("#txtCreatingUsersCreate_Company").val()
	}, 
	function(data)
	{	
		data = parseInt(data);
		if (isNaN(data)) 
		{ 
			$("#CompanyData").slideDown();
			$("#txtCreatingUsersCreate_CompanyUrl").focus();
		}
		else
		{ 
			btnCompanyDataCancel_click(evento);
		} 
	});		
}
