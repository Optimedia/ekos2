<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	class HandlerAddress extends SqlManager {
		
		private $_table = "eko_detail_address";
		
		public function HandlerAddress() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Fun��o para inserir um novo cadastro da tabela 'eko_profile'
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param CompleteUserVO
		 */
		/*public function doInsert(CompleteUserVO $profile) {
			$arrayProfile = array ('profile_id' => $profile -> account_id,
								   'nickname' => $profile -> nickname);
							  
			return parent::doInsert($arrayProfile, "eko_profile");
		}*/
		
		/**
		 * Fun��o para atualizar um cadastro na tabela 'eko_profile'
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param CompleteUserVO
		 */
		public function doUpdate(CompleteUserVO $profile) {
			
			$addressArray = $profile -> addressArray;			
			
			foreach($addressArray as $value) {
				$addressFinalArray = array ('profile_id' => $value -> account_id,
									   'detail_address_type_id' => $value -> detail_address_type_id,
									   'country_name' => $value -> country_name,
									   'state_name' => $value -> state_name,
									   'city_name' => $value -> city_name,
							    	   'town_name' => $value -> town_name,
									   'address_part1' => $value -> address_part1,
									   'address_part2' => $value -> address_part2,
									   'zipcode' => $value -> zipcode);
				
				$condition = "profile_id=".$value -> account_id." AND detail_address_type_id=".$value -> detail_address_type_id;
				
				$resultDelete = parent::doDelete($condition, $this -> _table);
				
				if($resultDelete) {
					$resultUpdate = parent::doInsert($addressFinalArray, $condition, "eko_profile");
					
					if($resultUpdate != true) {
						return "Erro no doUpdate Adress";
					} else {
						$ctrl = true;
					}
				}
				
			}
			
			return $ctrl;
		}
		
	}
	
?>
