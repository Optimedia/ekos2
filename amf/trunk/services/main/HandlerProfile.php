<?php
	
	require_once './LdapIntegration.php';
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/UserVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/ProfileVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/AccountVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	class HandlerProfile extends SqlManager {
		
		public function HandlerProfile() {
			parent::SqlManager();
		}
		
		/**
		 * Função para inserir um novo cadastro da tabela 'eko_profile'
		 * 
		 * @return Boolean
		 */		
		public function doInsert(ProfileVO $profile) {
			
			$arrayProfile = array ('profile_id' => $profile -> profile_id);
							  
			return parent::doInsert($arrayProfile, "eko_profile");
		}
		
	}
	
?>
