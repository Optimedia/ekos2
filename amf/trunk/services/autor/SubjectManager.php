<?php
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/SubjectVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/PresentationVO.php';

	class SubjectManager extends SqlManager {
		
		public function SubjectManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
	/**
		 * Função que retorna todos os módulos
		 *  
		 * - Retorna: Array - ModuleVO
		 * .
		 */
		public function getModules() {
			
			$sql = "SELECT * FROM ath_subject";
			$query = parent::doSelect($sql);
			
			$subject = new SubjectVO();
			$subjectArray = array();
			
			while($subject = mysql_fetch_object($query, "SubjectVO")) {
				$subjectArray[] = $subject;
			}
			
			foreach($subjectArray as $key => $value) {
				$sql = "";
			}
			
			return $subjectArray;
		}
		
	}