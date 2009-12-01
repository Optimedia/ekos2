<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	/**
	 * Classe para gerenciar os amigos do ekos.
	 */
	class FriendManager extends SqlManager {
		
		private $_table = "eko_friend";
		
		public function FriendManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Função para pegar toda a lista de amigos do usuário.
		 * 
		 * - Retorna: Array CompleteUserVO 
		 * .
		 * @param uint
		 */
		public function getAllFriends($user_id) {
			$sql = "SELECT f.*, a.* ,u.*, p.* FROM eko_friend f, eko_account a, eko_user u, eko_profile p ".
				   "WHERE profile_id_i=$user_id AND account_id=f.profile_id_you AND u.user_id=f.profile_id_you AND p.profile_id=f.profile_id_you";
				   
			$result = parent::doSelect($sql);
			
			$completeUser = new CompleteUserVO();
			$arrayCompleteUser = array();
			
			while($completeUser = mysql_fetch_object($result, "CompleteUserVO")) {
				$arrayCompleteUser[] = $completeUser;
			}
			
			return $arrayCompleteUser;
			
		}
		
		/**
		 * Função para pegar adicionar um amigo.
		 * 
		 * - Retorna: Boolean 
		 * .
		 * @param uint
		 * @param uint
		 */
		public function addFriend($i, $you) {
			$arrayFriend = array ('profile_id_i' => $i,
								  'profile_id_you' => $you);
			
			return parent::doInsert($arrayFriend, $this -> _table);
		}
		
		/**
		 * Função para deletar um amigo.
		 * 
		 * - Retorna: Boolean 
		 * .
		 * @param uint
		 * @param uint
		 */
		public function removeFriend($i, $you) {
			$where = "profile_id_i=$i AND profile_id_you=$you";
			
			return parent::doDelete($where, $this -> _table);
		}
		
	}
	
?>
