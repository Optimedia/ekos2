<?php
	
	require_once './LdapIntegration.php';
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	class HandlerUser extends SqlManager {
		
		public function HandlerUser() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Funчуo para inserir um novo cadastro da tabela 'eko_user'
		 * 
		 * @return Boolean 
		 */		
		public function doInsert(UserVO $user) {
			
			$arrayUser = array ('user_id' => $user -> user_id);
							  
			return parent::doInsert($arrayUser, "eko_user");
		}
		
	}
	
?>