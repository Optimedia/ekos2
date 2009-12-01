<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	// FriendManager
	// IgnoreManager
	// MessageManager
	
	class ProfileManager extends SqlManager {
		
		public function ProfileManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Fun��o para buscar dados do profile
		 * 
		 * - Retorna: CompleteUserVO
		 * .
		 * @param uint
		 */
		public function getProfile($user_id) {
			require_once './UserManager.php';
			$userManager = new UserManager();
			
			return $userManager -> getUser($user_id);
		}
		
		/**
		 * Fun��o para atualizar dados do usu�rio
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param CompleteUserVO
		 */
		public function updateProfile(CompleteUserVO $completeUser) {
			require_once './UserManager.php';
			$userManager = new UserManager();
			
			return $userManager -> updateUser($completeUser);			
		}
		
		/**
		 * Fun��o para pegar toda a lista de amigos do usu�rio.
		 * 
		 * - Retorna: Array CompleteUserVO 
		 * .
		 * @param uint
		 */
		public function getAllFriend($user_id) {
			// por fora
		}
		
		/**
		 * Fun��o para pegar toda a lista de amigos do usu�rio.
		 * 
		 * - Retorna: Array CompleteUserVO 
		 * .
		 * @param uint
		 */
		public function getAllIgnore($user_id) {
			
		}
		
		/**
		 * Fun��o para pegar toda a lista de amigos do usu�rio.
		 * 
		 * - Retorna: Array CompleteUserVO 
		 * .
		 * @param uint
		 */
		public function getAllScrap($user_id) {
			
		}
		
		/**
		 * Fun��o para pegar todas as mensagens do usu�rio.
		 * 
		 * - Retorna: Array CompleteUserVO
		 * .
		 * @param uint
		 */
		public function getAllMessage($user_id) {
			
		}
		
	}
	
?>