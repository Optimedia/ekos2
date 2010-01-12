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
			
			$sql = "SELECT * FROM eko_detail_language";
			
			$result = parent::doSelect($sql);
			
			require_once '../vo/br/com/optimedia/assets/vo/LanguageVO.php';
			$language = new LanguageVO();
			
			$arrayLanguage = array();
			
			while($language = mysql_fetch_object($result, "LanguageVO")) {
				$arrayLanguage[] = $language;
			}
			
			return $arrayLanguage;
			
		}
		
	}