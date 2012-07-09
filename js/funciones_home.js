var Usuario;
$(document).on("ready", arranque);

function arranque()
{
	$("#btnCerrarSesion").on("click", btnCerrarSesion_Click);
	$("#btnIniciarSesion").on("click", btnIniciarSesion_Click);
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
function btnIniciarSesion_Click()
{
	$("#frmIniciarSesion").dialog(
			{
		autoOpen: false, 		
		buttons: [
					{
						text: "Ingresar",
						click: function()
									{
										IniciarSesion();
										ResetearContenedor("frmIniciarSesion");
									}
					},
					{
						text: "Cancelar",
						click: function()
									{
										$(this).dialog("close");
										ResetearContenedor("frmIniciarSesion");
									}
					}
				],
		minWidth: 620,
		modal: true,
		title : 'Iniciar Sesión'
			});
			$("#frmIniciarSesion").dialog('open');
}
function CargarUsuario()
{
	Usuario = JSON.parse(localStorage.Usuario)[0];
	$("#lblWelcome span").text(Usuario.NickName);
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
function ResetearContenedor(IdContenedor)
{
		  $('#' + IdContenedor).find(':input').each(function() {
			if ($(this).attr('type') != 'submit')
			  {
                $(this).val('');
              }
			});
}
