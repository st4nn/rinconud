var Usuario;
$(document).on("ready", arranque);

function arranque()
{
	$("#btnCerrarSesion").on("click", btnCerrarSesion_Click);
	$("#btnCompanyDataCancel").on("click", btnCompanyDataCancel_click);
	$("#btnCompanyDataCreate").on("click", btnCompanyDataCreate_click);
	$("#btnIniciarSesion").on("click", btnIniciarSesion_Click);
	$("#CreatingUsersCreate").on('submit', CrearUsuario);
	$("#txtCreatingUsersCreate_Company").live("change", VerificarEntidad);
	CargarUsuario();
}

function abrirPopup(url)
{
	popupWin = window.open(url, 'open_window');
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
		//CargarPermisos(Usuario.Id);
		$("#btnIniciarSesion").slideUp();
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
				//EditarPermisos(Id);
				MostrarAlerta("CreatingUsers_Create", "default", "ui-icon-circle-check", "Hey!", "El Usuario ha sido creado");
				ResetearContenedor("CreatingUsersCreate");
			} 
		});	
	} else
	{
		MostrarAlerta("CreatingUsers_Create", "error", "ui-icon-alert", "Error!", "Las Claves deben ser iguales");
	}
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
