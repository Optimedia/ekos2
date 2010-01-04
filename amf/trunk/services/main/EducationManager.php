<?php

	require_once '../includes/SqlManager.php';

	class EducationManager extends SqlManager {
		
		private $_table = "eko_detail_education";
		
		public function EducationManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Função para buscar os níveis de educação.
		 * 
		 * - Retorna: Array
		 * .
		 *
		 */
		public function getEducationLevel() {
			
			$sql = "SELECT * FROM eko_detail_education_level";
			
			$result = parent::doSelect($sql);
			
			$arrayEducationLevel = array();
			
			while($educationLevel = mysql_fetch_array($result, MYSQL_ASSOC)) { 
				$arrayEducationLevel[] = $educationLevel;
			}
			
			return $arrayEducationLevel;
			
		}
		
	}