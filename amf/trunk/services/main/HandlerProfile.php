<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	class HandlerProfile extends SqlManager {
		
		private $_table = "eko_profile";
		
		public function HandlerProfile() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Função para inserir um novo cadastro da tabela 'eko_profile'
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param CompleteUserVO
		 */
		public function doInsert(CompleteUserVO $profile) {
			$arrayProfile = array ('profile_id' => $profile -> account_id);
							  
			return parent::doInsert($arrayProfile, "eko_profile");
		}
		
		/**
		 * Função para atualizar um cadastro na tabela 'eko_profile'
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param CompleteUserVO
		 */
		public function doUpdate(CompleteUserVO $profile) {
			$arrayProfile = array ('profile_id' => $profile -> account_id,
								   'alias' => $profile -> nickname,
								   'small_avatar' => $profile -> small_avatar,
								   'large_avatar' => $profile -> large_avatar,
								   'sex' => $profile -> sex,
								   'birthday' => $profile -> birthday);
							  
			$condition = "profile_id=".$profile -> account_id;
			
			return parent::doUpdate($arrayProfile, $condition, "eko_profile");
		}
		
	}
	
?>
