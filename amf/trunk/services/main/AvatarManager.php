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
		 * @return Boolean
		 */
		public function addFriend($i, $you) {
			$arrayFriend = array('profile_id_i' => $i,
								 'profile_id_you' => $you);
								 
			return parent::doInsert($arrayFriend, "eko_friend");
		}
		
		public function addIgnore($i, $you) {
			$arrayIgnore = array('profile_id_i' => $i,
								 'profile_id_you' => $you);
								 
			return parent::doInsert($arrayIgnore, "eko_ignore");
		}
		
	}
	
?>
