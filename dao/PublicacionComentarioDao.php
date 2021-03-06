<?php
include_once ($_SERVER["DOCUMENT_ROOT"] . '/dao/GenericDao.php');
include_once ($_SERVER["DOCUMENT_ROOT"] . '/model/publicacion_comentario.php');

class PublicacionComentarioDao {

	public static function get($id) {
		return GenericDao::get("publicacion_comentario", array("id" => $id));
	}// get

	public static function getXpublicacion($id_publicacion) {
		return GenericDao::find("publicacion_comentario", array(array("id_publicacion", "=", $id_publicacion)));
	}

	public static function getXcomentario($id_publicacion,$id_comentario) {
		return GenericDao::find("publicacion_comentario", array(array("id_publicacion", "=", $id_publicacion),array("reply", "=", $id_comentario)));
	}

	public static function nuevo($item) {
		$item->fecha = date("Y-m-d H:i:s", time());

		return GenericDao::insert($item);
	}// nuevo

	public static function modificar($item) {

		GenericDao::update($item);
	}// modificar

	public static function eliminar($item) {
		GenericDao::delete($item);
	}// eliminar
}

?>