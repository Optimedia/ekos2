<?php

	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	/**
	 * Classe para manipulação do Usuário, inserindo, alterando e confirmando dados. 
	 */
	class UserManager extends SqlManager {
		
		public function UserManager() {
			session_start();
			
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Função que retorna todos os usuários
		 *  
		 * - Retorna: Array - CompleteUserVO
		 * .
		 */
		public function getAllUser() {
			
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
		 * Função para buscar dados do profile
		 * 
		 * - Retorna: CompleteUserVO
		 * .
		 * @param uint
		 */
		public function getUser($user_id) {
			$sql = "SELECT a.* ,u.*, p.* FROM eko_account a, eko_user u, eko_profile p WHERE account_id=$user_id AND u.user_id=a.account_id AND p.profile_id=a.account_id";
			$result = parent::doSelect($sql);
			
			$completeUser = new CompleteUserVO();
			
			$completeUser = mysql_fetch_object($result, "CompleteUserVO");
			
			return $completeUser;
		}
		
		/**
		 * Função para inserir um novo usuário
		 * 
		 * - Retorna: Boolean | ArrayErrors
		 * 
		 * @param CompleteUserVO
		 */
		public function insertUser(CompleteUserVO $completeUser) {
						
			// Tabelas a serem inseridas - o Account DEVE ser o primeiro, pois elé a referência para os IDs das outras tabelas.
			$handler_names = array ('Account', 'Ldap', 'Profile', 'User');
			
			
			foreach($handler_names as $key => $value) {
			
				$handlerName = 'Handler' . $value;
				
				require "$handlerName.php";
				$handler = new $handlerName();
				
				// Chamando o método para inserir os dados no bd, todos os métodos esperam um CompleteUserVO e utiliza somente
				// os dados que são da tabela.
	      		$result = $handler->doInsert($completeUser);
				if($value == "Account") {
					if(is_int($result)) {
						$completeUser -> account_id = $result;
					} else {
						return $result;
					}					
				} else {
					if($result != true) {
						return $result;
					}
				}
			}
			
			// Enviando confirmação de cadastro
			/*$to      = $completeUser -> email;
			$subject = "Confirmação de cadastro [".$completeUser -> name."].";
			$message = "codigo de ativação: ".md5($completeUser -> email.$completeUser -> name);
			$headers = "From: Suporte I-brasil.net <no-reply@i-brasil.net>" . "\r\n" .
		    "Reply-To: no-reply@i-brasil.net" . "\r\n" . "X-Mailer: PHP/" . phpversion();		
			
			if(!mail($to, $subject, $message, $headers)) {
				$result[] = "error";
				
				return $result;
			} else {*/
				return true;
			//}
						
		}
		
		/**
		 * Função para atualizar dados do usuário
		 * 
		 * - Retorna Boolean
		 * .
		 * @param CompleteUserVO
		 */
		public function updateUser(CompleteUserVO $completeUser) {
			// Tabelas a serem inseridas - o Account DEVE ser o primeiro, pois elé a referência para os IDs das outras tabelas.
			$handler_names = array ('Account', 'Profile', 'User');
			
			$error = 0;
			
			foreach($handler_names as $key => $value) {
			
				$handlerName = 'Handler' . $value;
				
				require "$handlerName.php";
				$handler = new $handlerName();
				
				// Chamando o método para inserir os dados no bd, todos os métodos esperam um CompleteUserVO e utiliza somente
				// os dados que são da tabela.
	      		$result = $handler->doUpdate($completeUser);
				
				if($result != true) {
					$error ++;
				}
			}
			
			if($error == 0) {
				return true;
			} else {
				return false;
			}
		}
		
		/**
		 * Função para verificar se o 'email' já está sendo utlizado
		 * 
		 * - Retorna: Boolean
		 * 
		 * @param String
		 */
		public function verifEmail($email) {
			require_once "./HandlerAccount.php";
			$handlerAccount = new HandlerAccount();
			
			return $handlerAccount -> getEmail($email);
		}
		
		/**
		 * Função para verificar se o 'name'já está sendo utilizado (Login)
		 * 
		 * @return Boolean
		 */
		public function verifName($name) {
			require_once "./HandlerAccount.php";
			$handlerAccount = new HandlerAccount();
			
			return $handlerAccount -> getName($name);
		}
		
		/**
		 * Função para validar o email cadastrado.
		 * 
		 * @return Boolean
		 */
		public function confEmail($name, $cod) {
			$sql = "SELECT email FROM eko_account WHERE name='$name'";
			
			$result = parent::doSelect($sql);
			
			$verifCod = md5($name.mysql_result($result, 0, "email"));
			
			if($verifCod != $cod) {
				return false;
			} else {
				$array = array("status" => 2);
				$condition = "name='$name'";
				
				return parent::doUpdate($array, $condition, "eko_account"); 
			}
		}
		
		/**
		 * Função para lembrar a senha, enviando ao email cadastrado
		 * 
		 * @return Boolean
		 */		
		public function getPassword($emailOrName) {			
			$sql = "SELECT a.account_id, u.password FROM eko_account a, eko_user u WHERE (a.name='$emailOrName' OR a.email='$emailOrName') AND u.user_id=a.account_id";
			$result = parent::doSelect($sql);
			
			if(mysql_num_rows($result) > 0) {
				// Enviar email
				
				return mysql_result($result, 0, "password");
			} else {
				return false;
			}			
		}
	}
	
?>
