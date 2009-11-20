<?php
	
	require_once './LdapIntegration.php';
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/UserVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/ProfileVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/AccountVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	class HandlerUser extends SqlManager {
		
		public function HandlerUser() {
			parent::SqlManager();
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