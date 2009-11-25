<?php
	
	require_once './LdapIntegration.php';
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	class HandlerAccount extends SqlManager {
		
		public function HandlerAccount() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Função para inserir um novo cadastro da tabela 'eko_account'
		 * 
		 * @return uint 
		 */		
		public function doInsert(CompleteUserVO $account) {
			
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
