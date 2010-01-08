<?php

	require_once '../includes/SqlManager.php';

	class AdressManager extends SqlManager {
		
		private $_table = "eko_detail_address";
		
		public function AdressManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Função para buscar os tipos de endereço
		 * 
		 * - Retorna: Array
		 * .
		 *
		 */
		public function getAdressTypes() {
			
			$sql = "SELECT * FROM eko_detail_address_type";
			
			$result = parent::doSelect($sql);
			
			$arrayAdressType = array();
			
			while($adressType = mysql_fetch_array($result, MYSQL_ASSOC)) { 
				$arrayAdressType[] = $adressType;
			}
			
			return $arrayAdressType;
			
		}
		
	}