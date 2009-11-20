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
			
			parent::SqlManager();
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
		
		public function insertUser(CompleteUserVO $completeUser) {
			
			// Tabelas a serem inseridas - o Account DEVE ser o primeiro, pois elé a referência para os IDs das outras tabelas.
			$handler_names = array ('Account', 'Ldap', 'Profile', 'User');
			
			// Montando o Array, chamando o método 'doInsert' de cada Handler para inserir no banco de dados.
			$account = new AccountVO();
			$profile = new ProfileVO();
			$user = new UserVO();			
			
			// AccountVO
			$account -> email = $completeUser -> email;
			$account -> name = $completeUser -> name;
			$account -> status = 1;
			
			// HandlerAccount - doInsert
			require_once "HandlerAccount.php";
			$handlerAccount = new HandlerAccount();
			$accountResult = $handlerAccount -> doInsert($account);
			
			// ProfileVO
			$profile -> profile_id = $accountResult;
			
			// HandlerProfile - doInsert
			require_once "HandlerProfile.php";
			$handlerProfile = new HandlerProfile();
			$profileResult = 
			
			// doInsert
			foreach ($handler_names as $key => $value) {
			
				$handlerName = 'Handler'.$value;
				require_once "$handlerName.php";
				
				$handler = new $handlerName();
				
	   			$errors = $handler->doInsert($dataIdm);
	   			
			}
			
			// ProfileVO
			$profile -> profile_id = ""; // Ultimo ID inserido na table account
									
		}	
	}
	
?>
