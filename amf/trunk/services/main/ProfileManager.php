<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	require_once '../includes/thumbnail_generator.php';
	require_once '../vo/br/com/optimedia/assets/vo/FileVO.php';
	
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
		 * 
		 */
		public function getProfile() {
			require_once './UserManager.php';
			$userManager = new UserManager();
			
			return $userManager -> getUser($_SESSION['complete_user_vo']->account_id);
		}
		
		/**
		 * Função para atualizar dados do usuário
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
		 * 
		 */
		public function getAllFriend() {
			require_once './FriendManager.php';
			$friendManager = new FriendManager();
			
			return $friendManager -> getAllFriends();
		}
		
		/**
		 * Fun��o para pegar toda a lista de amigos do usu�rio.
		 * 
		 * - Retorna: Array CompleteUserVO 
		 * .
		 */
		public function getAllIgnores() {
			require_once './IgnoreManager.php';
			$ignoreManager = new IgnoreManager();
			
			return $ignoreManager -> getAllIgnores($_SESSION['complete_user_vo']->account_id);
		}
		
		/**
		 * Fun��o para pegar toda a lista de amigos do usu�rio.
		 * 
		 * - Retorna: Array CompleteUserVO 
		 * .
		 * 
		 */
		public function getAllScrap() {
			
		}
		
		/**
		 * Fun��o para pegar todas as mensagens recebidas pelo usu�rio.
		 * 
		 * - Retorna: Array MessageVO
		 * .
		 * 
		 */
		public function getAllReciveMessages() {			
			require_once './MessageManager.php';
			$messageManager = new MessageManager();
			
			return $messageManager -> getAllMessages($_SESSION['complete_user_vo']->account_id);
		}
		
		/**
		 * Função para buscar os níveis de educação.
		 * 
		 * - Retorna: Array [detail_education_level_id] | [name]
		 * .
		 *
		 */
		public function getEducationLevels() {
			require_once "./EducationManager.php";
			$educationManager = new EducationManager();
			
			return $educationManager -> getEducationLevels();
		}
		
		/**
		 * Função para buscar os níveis de educação.
		 * 
		 * - Retorna: Array [eko_detail_address_type] | [name]
		 * .
		 *
		 */
		public function getAddressTypes() {
			require_once "./AddressManager.php";
			$adressManager = new AddressManager();
			
			return $adressManager -> getAddressTypes();
		}
		
		public function getAvaliableLanguages() {
			// TODO Pegar as linguas
		}
		
		public function uploadFile(FileVO $file) { 
			$data = $file->filedata->data;
			$filename = mt_rand() . $file->filename;
			file_put_contents( 'avatars/' . $filename, $data);
			createthumb("avatars/$filename","avatars/160x160/$filename", 160, 160);
			createthumb("avatars/$filename","avatars/100x100/$filename", 100, 100);
			return $filename;
		}
		
	/**
		 * Fun��o que retorna se a sess�o est� ativa ou n�o.
		 * 
		 * @return CompleteUserVO
		 */
		public function getSession() {
			if($_SESSION['user_logged']) {
				return $_SESSION['account_id']; // CompleteUserVO
			} else {
				return false;
			}
		}
	}
	
?>