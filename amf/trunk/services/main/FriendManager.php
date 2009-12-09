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
		 * Fun��o para pegar toda a lista de amigos do usu�rio.
		 * 
		 * - Retorna: Array CompleteUserVO 
		 * .
		 * @param uint
		 */
		public function getAllFriends($user_id) {
			$sql = "SELECT f.*, a.account_id ,u.first_name, u.last_name, p.small_avatar, p.nickname FROM eko_friend f, eko_account a, eko_user u, eko_profile p ".
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
		 * Fun��o para buscar um profile pelo nome, sobrenome ou nickname.
		 * 
		 * - Retorna: Array CompleteUserVO
		 * .
		 * @param String
		 */
		public function findFriend($name) {
			$sql = "SELECT a.account_id ,u.first_name, u.last_name, p.small_avatar, p.nickname FROM eko_account a, eko_user u, eko_profile p " .
					"WHERE (p.nickname LIKE '%$name%' OR u.first_name LIKE '%$name%' OR u.last_name LIKE '%$name%') AND " .
					"u.user_id=a.account_id AND p.profile_id=a.account_id";
			
			$result = parent::doSelect($sql);
			
			$completeUser = new CompleteUserVO();
			$arrayCompleteUser = array();
			
			while($completeUser = mysql_fetch_object($result, "CompleteUserVO")) {
				$arrayCompleteUser[] = $completeUser;
			}
			
			return $arrayCompleteUser;
		}
		
		/**
		 * Fun��o para pegar adicionar um amigo.
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
		 * Fun��o para deletar um amigo.
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
