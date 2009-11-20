<?php
	
	require_once './LdapIntegration.php';
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/UserVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/ProfileVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/AccountVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	class HandlerAccount extends SqlManager {
		
		public function HandlerAccount() {
			parent::SqlManager();
		}
		
		/**
		 * Função para inserir um novo cadastro da tabela 'eko_account'
		 * 
		 * @return uint 
		 */		
		public function doInsert(AccountVO $account) {
			
			$arrayAccount = array ('email' => $account -> email,
								   'name' => $account -> name,
								   'status' => $account -> status);
							  
			if(!parent::doInsert($arrayAccount, "eko_account")) {
				return false;
			} else {
				$lastId = mysql_insert_id(); 
				return $lastId;
			}
		}
		
	}
	
?>
