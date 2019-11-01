<?php
include_once ($_SERVER["DOCUMENT_ROOT"] . '/site/utiles/Utiles.php');

Utiles::ValidarSesionIniciada();

$token = isset($_POST['token']) ? $_POST['token'] : $_GET['token'];
$accion = isset($_POST['accion']) ? $_POST['accion'] : $_GET['accion'];

if (isset($token) && $token == Utiles::obtenerToken()) {

	include_once ($_SERVER["DOCUMENT_ROOT"] . '/dao/UsuarioObjetivoDao.php');
	include_once ($_SERVER["DOCUMENT_ROOT"] . '/dao/UsuarioDao.php');

	switch ($accion) {
		case 'modificar-objetivos':
			$valido = true;
			$errores = '<strong>Ocurrieron los siguientes errores:</strong>';
			
			$objetivos = json_decode($_POST['objetivos']);
			
			if (!isset($objetivos) || $objetivos == ''  || count($objetivos) == 0) {
				$errores .= '<p>- Debe seleccionar al menos un objetivo.</p>';
				$valido = false;
			}

			if ($valido) {
				$objetivosUsuario = UsuarioObjetivoDao::listXusuario(Utiles::obtenerIdUsuarioLogueado());
				//Elimino objetivos
				foreach ($objetivosUsuario as $objetivosActuales) {
					$borrar = true;
					$i = 0;
					foreach ($objetivos as $objetivo) {
						if ($objetivo->id == $objetivosActuales->id_objetivo) {
							$borrar = false;
							
							$objetivosActuales->fecha_inicio = ($objetivo->fecha_inicio == null || $objetivo->fecha_inicio == '' ? null : $objetivo->fecha_inicio);
							$objetivosActuales->fecha_fin = ($objetivo->fecha_fin == null || $objetivo->fecha_fin == '' ? null : $objetivo->fecha_fin);
							
							UsuarioObjetivoDao::modificar($objetivosActuales);

							array_splice($objetivos, $i, 1);
						}
						$i++;
					}

					if ($borrar) {

						UsuarioObjetivoDao::eliminar($objetivosActuales->id);
					}
				}

				// Guardo objetivos
				if ($objetivos != null && count($objetivos) > 0) {
					foreach($objetivos as $objetivo)
					{
						$obj = new usuario_objetivo();
						$obj->id_usuario = Utiles::obtenerIdUsuarioLogueado();
						$obj->id_objetivo = $objetivo->id;
						$obj->fecha_inicio = ($objetivo->fecha_inicio == null || $objetivo->fecha_inicio == '' ? null : $objetivo->fecha_inicio);
						$obj->fecha_fin = ($objetivo->fecha_fin == null || $objetivo->fecha_fin == '' ? null : $objetivo->fecha_fin);
						
						UsuarioObjetivoDao::nuevo($obj);
					}
				}
				
				echo 'OK|';

			} else {
				echo 'ERROR|<div class="alert dark alert-alt alert-danger fade in"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>' . $errores . '</div>';
			}
			break;

		case 'editar-perfil':
			
			$valido = true;
			$item = new usuario();
			$errores = '<strong>Ocurrieron los siguientes errores:</strong>';
			
			if (!isset($_POST['first_name']) || trim($_POST['first_name']) == '') {
				$errores .= '<p>- Debe ingresar al menos un nombre.</p>';
				$valido = false;

			}
			if (!isset($_POST['last_name']) || trim($_POST['last_name']) == '') {
				$errores .= '<p>- Debe ingresar al menos un apellido.</p>';
				$valido = false;

			}
			if (!isset($_POST['user_name']) || trim($_POST['user_name']) == '') {
				$errores .= '<p>- Debe ingresar un nombre de usuario.</p>';
				$valido = false;

			}
			if (!isset($_POST['email']) || trim($_POST['email']) == '') {
				$errores .= '<p>- Debe ingresar un email.</p>';
				$valido = false;

			}
			if (!isset($_POST['fecha_nac']) || trim($_POST['fecha_nac']) == '') {
				$errores .= '<p>- Debe ingresar una fecha de nacimiento.</p>';
				$valido = false;

			}
			/*if (!isset($_POST['password2']) || trim($_POST['password2']) == '') {
				$errores .= '<p>- Debe ingresar una contraseña.</p>';
				$valido = false;
			}*/

			if($valido) {

				$item = UsuarioDao::get(Utiles::obtenerIdUsuarioLogueado());
				$item->nombre = $_POST['first_name'];
				$item->apellido = $_POST['last_name'];
				$item->usuario = $_POST['user_name'];
				$item->mail = $_POST['email'];
				$item->fecha_nacimiento = $_POST['fecha_nac'];

				UsuarioDao::modificar($item);

				Utiles::recargarSesion($item);


				echo 'OK|';

			}else {
				echo 'ERROR|<div class="alert dark alert-alt alert-danger fade in"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>' . $errores . '</div>';
			}

		break;
		case 'cambiar-password' :
			
			$valido = true;
			$item = new usuario();
			$item = UsuarioDao::get(Utiles::obtenerIdUsuarioLogueado());
			$errores = '<strong>Ocurrieron los siguientes errores:</strong>';
			
			if (!isset($_POST['password']) || trim($_POST['password']) == '') {
				$errores .= '<p>- La contraseña no puede estar vacia</p>';
				$valido = false;
			}else if (!isset($_POST['password2']) || trim($_POST['password2']) == '') {
				$errores .= '<p>- La nueva contraseña no puede estar vacia</p>';
				$valido = false;
			}else if($item->password != $_POST['password']){
				$errores .= '<p>- La contraseña ingresada no es correcta. Intente nuevamente</p>';
				$valido = false;
			}


			if($valido) {

				$item->password = $_POST['password2'];

				UsuarioDao::modificar($item);

				Utiles::recargarSesion($item);


				echo 'OK|';

			}else {
				echo 'ERROR|<div class="alert dark alert-alt alert-danger fade in"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>' . $errores . '</div>';
			}
		
		break;
		case 'eliminar-cuenta' : 

			$valido = true;
			$item = new usuario();
			$item = UsuarioDao::get(Utiles::obtenerIdUsuarioLogueado());
			$errores = '<strong>Ocurrieron los siguientes errores:</strong>';

			if (!isset($_POST['password']) || trim($_POST['password']) == '') {
				$errores .= '<p>- La contraseña no puede estar vacia</p>';
				$valido = false;
			}else if (!isset($_POST['password2']) || trim($_POST['password2']) == '') {
				$errores .= '<p>- Debe completar ambos campos</p>';
				$valido = false;
			}else if($item->password != $_POST['password']){
				$errores .= '<p>- La contraseña ingresada no es correcta. Intente nuevamente</p>';
				$valido = false;
			}else if($_POST['password'] != $_POST['password2']){
				$errores .= '<p>- Las contraseñas no coinciden. Intente nuevamente</p>';
				$valido = false;
			}

			if($valido) {

				$item->activo = 0;

				UsuarioDao::modificar($item);

				Utiles::cerrarSesion($item);


				echo 'OK|';

			}else {
				echo 'ERROR|<div class="alert dark alert-alt alert-danger fade in"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>' . $errores . '</div>';
			}
			
	}

}
?>
