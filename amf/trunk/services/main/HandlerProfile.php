<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	class HandlerProfile extends SqlManager {
		
		public function HandlerProfile() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Função para inserir um novo cadastro da tabela 'eko_profile'
		 * 
		 * @return Boolean
		 */		
		public function doInsert(CompleteUserVO $profile) {
			
			$arrayProfile = array ('profile_id' => $profile -> account_id);
							  
			return parent::doInsert($arrayProfile, "eko_profile");
		}
		
	}
	
?>
