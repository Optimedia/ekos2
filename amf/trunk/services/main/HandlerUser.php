<?php
	
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
		 * Funчуo para inserir um novo cadastro da tabela 'eko_profile'
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param CompleteUserVO
		 */
		public function doInsert(CompleteUserVO $user) {
			$arrayUser = array ('user_id' => $user -> account_id,
								'first_name' => $user -> first_name,
								'last_name' => $user -> last_name,
								'password' => $user -> password);
							  
			return parent::doInsert($arrayUser, "eko_user");
		}
		
		/**
		 * Funчуo para atualizar um cadastro na tabela 'eko_profile'
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param CompleteUserVO
		 */
		public function doUpdate(CompleteUserVO $user) {
			$arrayUser = array ('first_name' => $user -> first_name,
								'last_name' => $user -> last_name,
								'password' => $user -> password);
							  
			$condition = "user_id=".$user -> account_id;
			
			return parent::doUpdate($arrayUser, $condition, "eko_user");
		}
		
	}
	
?>