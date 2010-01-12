<?php

	require_once '../includes/SqlManager.php';

	class LanguageManager extends SqlManager {
		
		private $_table = "eko_detail_address";
		
		public function LanguageManager() {
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
		public function getLanguage() {
			
			$sql = "SELECT * FROM eko_detail_language_option";
			
			$result = parent::doSelect($sql);
			
			$arrayLanguage = array();
			
			while($language = mysql_fetch_array($result, MYSQL_ASSOC)) { 
				$arrayLanguage[] = $language;
			}
			
			return $arrayLanguage;
			
		}
		
	}