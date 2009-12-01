<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	class HandlerAccount extends SqlManager {
		
		private $_table = "eko_account"; 
		
		public function HandlerAccount() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Funчуo para inserir um novo cadastro da tabela 'eko_account'
		 * 
		 * - Retorna: uint / false
		 * .
		 * @param CompleteUserVO 
		 */		
		public function doInsert(CompleteUserVO $account) {
			$arrayAccount = array ('email' => $account -> email,
								   'name' => $account -> name);
			
			$result = parent::doInsert($arrayAccount, $this -> _table);
					  
			if($result) {
				$lastId = mysql_insert_id(); 
				return $lastId;
			} else {
				return $result;
			}
		}
		
		/**
		 * Funчуo para atualizar os dados.
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param CompleteUserVO
		 */
		public function doUpdate(CompleteUserVO $account) {
			$arrayAccount = array ('email' => $account -> email,
								   'name' => $account -> name);

			$condition = "account_id=".$account -> account_id;

			return parent::doUpdate($arrayAccount, $condition,  $this -> _table);
		}
		
		/**
		 * Funчуo para verificar se o 'email' estс liberado
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param String
		 */
		public function getEmail($email) {
			$sql = "SELECT email FROM ".$this -> _table." WHERE email='$email'";
			
			$result = parent::doSelect($sql);
			
			if(mysql_num_rows($result) > 0) {
				return false;
			} else {
				return true;
			}
		}
		
		/**
		 * Funчуo para verificar se o 'name' estс liberado
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param String
		 */
		public function getName($name) {
			$sql = "SELECT name FROM ".$this -> _table." WHERE name='$name'";
			
			$result = parent::doSelect($sql);
			
			if(mysql_num_rows($result) > 0) {
				return false;
			} else {
				return true;
			}
		}
		
	}
	
?>