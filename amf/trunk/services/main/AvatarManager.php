<?php
	
	require_once '../includes/SqlManager.php';
	
	class AvatarManager extends SqlManager {
		
		public function AvatarManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Função para adicionar um profile como amigo
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param uint
		 * @param uint
		 */
		public function addFriend($i, $you) {
			require_once './FriendManager.php';
			$friendManager = new FriendManager();
			
			return $friendManager -> addFriend($i, $you);
		}
		
		/**
		 * Função para adicionar um profile como ignorado
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param uint
		 * @param uint
		 */
		public function addIgnore($i, $you) {
			require_once './IgnoreManager.php';
			$ignoreManager = new IgnoreManager();
			
			return $ignoreManager -> addFriend($i, $you);
		}
		
		/**
		 * Função para enviar uma mensagem privada
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param MessageVO
		 */
		public function sendPrivateMessage(MessageVO $message) {
			require_once './MessageManager.php';
			$messageManager = new MessageManager();
			
			return $messageManager -> sendPrivateMessage($message);
		}
		
	}
	
?>
