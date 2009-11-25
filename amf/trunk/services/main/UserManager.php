<?php
	
	require_once './LdapIntegration.php';
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/UserVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/ProfileVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/AccountVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	class UserManager extends SqlManager {
		
		private $ldap;
		
		public function UserManager() {
			session_start();
		 	$this->ldap = new LdapIntegration();
			
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Função que retorna todos os usuários
		 *  
		 * @return Array CompleteUserVO
		 */
		public function getUser() {
			
			$sql = "SELECT a.* ,u.*, p.* FROM eko_account a, eko_user u, eko_profile p WHERE u.user_id=a.account_id AND p.profile_id=a.account_id";
			$query = parent::doSelect($sql);
			
			$completeUser = new CompleteUserVO();
			$completeUserArray = array();
			
			while($completeUser = mysql_fetch_object($query, "CompleteUserVO")) {
				$completeUserArray[] = $completeUser;
			}
			
			return $completeUserArray;
		}
		
		/**
		 * Função para inserir um novo usuário
		 * 
		 * @return Boolean ArrayErrors
		 */
		public function insertUser(CompleteUserVO $completeUser) {
			
			// Tabelas a serem inseridas - o Account DEVE ser o primeiro, pois elé a referência para os IDs das outras tabelas.
			$handler_names = array ('Account', 'Ldap', 'Profile', 'User');
			
			foreach($handler_names as $key => $value) {
			
				$handlerName = 'Handler' . $value;
				
				require "$handlerName.php";
				$handler = new $handlerName();
				
	      		$result = $handler->doInsert($completeUser);
				if($result == false) {
					return array("$handlerName");
				} else {
					if($value == "Account") {
						$completeUser -> account_id = $result;
					}
				}
			}
			
			// Enviando confirmação de cadastro
			$to      = $completeUser -> email;
			$subject = "Confirmação de cadastro [".$completeUser -> name."].";
			$message = "codigo de ativação: ".md5($completeUser -> email.$completeUser -> name);
			$headers = "From: Suporte I-brasil.net <no-reply@i-brasil.net>" . "\r\n" .
		    "Reply-To: no-reply@i-brasil.net" . "\r\n" . "X-Mailer: PHP/" . phpversion();		
			
			if(!mail($to, $subject, $message, $headers)) {
				$result[] = "error";
				
				return $result;
			} else {
				return true;
			}
						
		}	
	}
	
?>
