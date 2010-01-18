<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	/**
	 * Classe para gerenciar os ignorados do ekos.
	 */
	class IgnoreManager extends SqlManager {
		
		private $_table = "eko_ignore";
		
		public function IgnoreManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Fun��o para pegar toda a lista de ignorados do usu�rio.
		 * 
		 * - Retorna: Array CompleteUserVO 
		 * .
		 * @param uint
		 */
		public function getAllIgnores() {
			$sql = "SELECT i.*, a.* ,u.*, p.* FROM eko_ignore i, eko_account a, eko_user u, eko_profile p ".
				   "WHERE profile_id_i=".$_SESSION['account_id']." AND account_id=i.profile_id_you AND u.user_id=i.profile_id_you AND p.profile_id=i.profile_id_you";
				   
			$result = parent::doSelect($sql);
			
			$completeUser = new CompleteUserVO();
			$arrayCompleteUser = array();
			
			while($completeUser = mysql_fetch_object($result, "CompleteUserVO")) {
				$arrayCompleteUser[] = $completeUser;
			}
			
			return $arrayCompleteUser;
			
		}
		
		/**
		 * Fun��o para pegar adicionar um usuario a lista de ignorados.
		 * 
		 * - Retorna: Boolean 
		 * .
		 * @param uint
		 * @param uint
		 */
		public function addIgnore($you) {
			$arrayIgnore = array ('profile_id_i' => $_SESSION['account_id'],
								  'profile_id_you' => $you);
			
			return parent::doInsert($arrayIgnore, $this -> _table);
		}
		
		/**
		 * Fun��o para deletar um usuario da lista de ignorados.
		 * 
		 * - Retorna: Boolean 
		 * .
		 * @param uint
		 * @param uint
		 */
		public function removeIgnore($i, $you) {
			$where = "profile_id_i=".$_SESSION['account_id']." AND profile_id_you=$you";
			
			return parent::doDelete($where, $this -> _table);
		}
		
	}
	
?>
