<?php

  	require_once './LdapIntegration.php';
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/UserVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/ProfileVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/AccountVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	/**
	* Função de Login do LDAP.
	*/
	class SsoConnect extends SqlManager {
		
		private $ldap;
		
		public function SsoConnect() {
			//session_id($_REQUEST[session_name()]);
			session_start();
		  $this->ldap = new LdapIntegration();
		  
		  $host = "10.1.1.10";
		  $user = "opti";
		  $pass = "opti";
		  $db = "ekos2";
		  
		  parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Função que faz o Login no LDAP, criando a sessão para o sso.
		 * 
		 * @return CompleteUserVO 
		 */		
		public function doLogin($login, $pass) {
			// Fazendo o login no LDAP
			$result = $this->ldap->bindAsUser($login, $pass);
			$result = gettype($result) == boolean ? $result : false;
			
			if ($result) {
								
				// Verificar status do usuário
				$sql = "SELECT a.* ,u.*, p.* FROM eko_account a, eko_user u, eko_profile p WHERE a.name='$login' AND u.user_id=a.account_id AND p.profile_id=a.account_id";
				$query = parent::doSelect($sql);
				
				$completeUser = new CompleteUserVO();
				$completeUser = mysql_fetch_object($query, "CompleteUserVO");
				
				/*$user = new UserVO();
				$user = $completeUser;
				
				$profile = new ProfileVO();
				$profile = $completeUser;
				
				return $user;*/
				
				switch ($completeUser -> status) {
					
					// Temporario
					case 1:
						return 2;
						break;
					
					// Ativo
					case 2:
					
						// Criar a sessão.
						$_SESSION['complete_user_vo'] = $completeUser;
						$_SESSION['user_logged'] = true;											
						return $completeUser;
						break;
					
					// Desativado					
					case 3:
						return 4;
						break;
					
					// Bloqueado
					case 4:
						return 5;
						break;
					
					// Apagado
					case 5:
						return 6;
						break;
				}
				
			} else {
				return 1; // Erro no login;
			}
		}
		
		/**
		 * Função que retorna se a sessão está ativa ou não.
		 * 
		 * @return CompleteUserVO
		 */
		public function getSession() {
			if(isset($_SESSION['user_logged'])) {
				return $_SESSION['complete_user_vo']; // CompleteUserVo
			} else {
				return false;
			}
		}
		
		public function doUpdate(CompleteUserVO $completeUser){
					
		}
		
		/**
		 * Função que destroi a sessão.
		 * 
		 * @return true
		 */	
		public function doLogout() {
			session_unset();
			session_destroy();
			return true;
		}
				
	}