<?php
	
	require('../includes/SqlManager.php');
	require('../vo/br/com/optimedia/assets/vo/CompleteUserVO.php');
	
	class CompleteUserManager extends SqlManager {
		
		public function CompleteUserManager() {
			
			$host = "10.1.1.10";
			$user = "opti";
			$password = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $password, $db);
		}
		
		public function getUser() {
			
			$sql = "SELECT a.* ,b.*, c.* FROM eko_account a, eko_user b, eko_profile c WHERE b.user_id=a.account_id AND c.profile_id=a.account_id";
			$query = parent::doSelect($sql);
			
			$completeUserVO = new CompleteUserVO();
			$completeUserVOArray = array();
			
			while($completeUserVO = mysql_fetch_object($query, "CompleteUserVO")) {
				$completeUserVOArray[] = $completeUserVO;
			}
			
			return $completeUserVOArray;
			
		}
		
	}
	
?>
