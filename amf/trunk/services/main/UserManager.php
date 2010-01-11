<?php

	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	/**
	 * Classe para manipula��o do Usu�rio, inserindo, alterando e confirmando dados. 
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
		 * Fun��o que retorna todos os usu�rios
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
		 * Fun��o para buscar dados do profile
		 * 
		 * - Retorna: CompleteUserVO
		 * .
		 * @param uint
		 */
		public function getUserData() {
			//return $_SESSION;
			$sql = "SELECT a.* ,u.*, p.* FROM eko_account a, eko_user u, eko_profile p WHERE account_id=".$_SESSION['account_id']." AND u.user_id=a.account_id AND p.profile_id=a.account_id";
			$result = parent::doSelect($sql);
			
			$completeUser = new CompleteUserVO();
			
			$completeUser = mysql_fetch_object($result, "CompleteUserVO");
			
			return $completeUser;
		}
		
		/**
		 * Fun��o para inserir um novo usu�rio
		 * 
		 * - Retorna: Boolean | ArrayErrors
		 * 
		 * @param CompleteUserVO
		 */
		public function insertUser(CompleteUserVO $completeUser) {
						
			// Tabelas a serem inseridas - o Account DEVE ser o primeiro, pois el� a refer�ncia para os IDs das outras tabelas.
			$handler_names = array ('Account', 'Ldap', 'Profile', 'User');
			
			
			foreach($handler_names as $key => $value) {
			
				$handlerName = 'Handler' . $value;
				
				require "$handlerName.php";
				$handler = new $handlerName();
				
				// Chamando o m�todo para inserir os dados no bd, todos os m�todos esperam um CompleteUserVO e utiliza somente
				// os dados que s�o da tabela.
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
			
			// Enviando confirma��o de cadastro
			/*$to      = $completeUser -> email;
			$subject = "Confirma��o de cadastro [".$completeUser -> name."].";
			$message = "codigo de ativa��o: ".md5($completeUser -> email.$completeUser -> name);
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
		 * Fun��o para atualizar dados do usu�rio
		 * 
		 * - Retorna Boolean
		 * .
		 * @param CompleteUserVO
		 */
		public function updateUser(CompleteUserVO $completeUser) {
			// Tabelas a serem inseridas - o Account DEVE ser o primeiro, pois el� a refer�ncia para os IDs das outras tabelas.
			$handler_names = array ('Account', 'Profile', 'User');
			
			$error = 0;
			
			foreach($handler_names as $key => $value) {
			
				$handlerName = 'Handler' . $value;
				
				require "$handlerName.php";
				$handler = new $handlerName();
				
				// Chamando o m�todo para inserir os dados no bd, todos os m�todos esperam um CompleteUserVO e utiliza somente
				// os dados que s�o da tabela.
	      		$result = $handler->doUpdate($completeUser);
				
				if($result != true) {
					$error ++;
				}
			}
			
			if($error == 0) {
				return $completeUser;
			} else {
				return false;
			}
		}
		
		/**
		 * Fun��o para verificar se o 'email' j� est� sendo utlizado
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
		 * Fun��o para verificar se o 'name'j� est� sendo utilizado (Login)
		 * 
		 * @return Boolean
		 */
		public function verifName($name) {
			require_once "./HandlerAccount.php";
			$handlerAccount = new HandlerAccount();
			
			return $handlerAccount -> getName($name);
		}
		
		/**
		 * Fun��o para validar o email cadastrado.
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
		 * Fun��o para lembrar a senha, enviando ao email cadastrado
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


//$um = new UserManager();
//echo "<pre>";
//var_dump($um->getUserData());