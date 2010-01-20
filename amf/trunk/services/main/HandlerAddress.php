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
		public function doUpdate(CompleteUserVO $value = NULL) {
			
			require_once '../vo/br/com/optimedia/assets/vo/AddressVO.php';
			$address = new AddressVO();
			$addressArray = $value -> addressArray;

			/* Teste
				
				$value = new CompleteUserVO();
				
				require_once '../vo/br/com/optimedia/assets/vo/AddressVO.php';
				
				$singleAddress1 = new AddressVO();
				$singleAddress2 = new AddressVO();
				
				$singleAddress1 -> detail_address_type_id = 1;
				$singleAddress1 -> country_name = "Brasil";
				$singleAddress1 -> state_name = "Distrito Federal";
				$singleAddress1 -> city_name = "Brasília";
				$singleAddress1 -> town_name = "Asa Sul";
				$singleAddress1 -> address_part1 = "902 Sul";
				$singleAddress1 -> address_part2 = "";
				$singleAddress1 -> zipcode = "72000000";
				
				$singleAddress2 -> detail_address_type_id = 2;
				$singleAddress2 -> country_name = "Brasil";
				$singleAddress2 -> state_name = "Distrito Federal";
				$singleAddress2 -> city_name = "Taguatinga";
				$singleAddress2 -> town_name = "Taguatinga Sul";
				$singleAddress2 -> address_part1 = "QSD 26";
				$singleAddress2 -> address_part2 = "Casa 5";
				$singleAddress2 -> zipcode = "72000000";
				
				// Details
				$value -> addressArray = array($singleAddress1, $singleAddress2);
				
				$addressArray = $value -> addressArray;
			
			*/
			
			foreach($addressArray as $address) {
				$addressFinalArray = array ('profile_id' => $_SESSION['account_id'],
									   		'detail_address_type_id' => $address -> detail_address_type_id,
									   		'country_name' => $address -> country_name,
									   		'state_name' => $address -> state_name,
									   		'city_name' => $address -> city_name,
							    	   		'town_name' => $address -> town_name,
									   		'address_part1' => $address -> address_part1,
									   		'address_part2' => $address -> address_part2,
									   		'zipcode' => $address -> zipcode);
				
				// Verificando se já está cadastrado.
				$condition = "profile_id=".$_SESSION['account_id']." AND detail_address_type_id=".$address -> detail_address_type_id;
				
				$sqlCheck = "SELECT * FROM ". $this -> _table ." WHERE ".$condition;
				$resultCheck = parent::doSelect($sqlCheck);
				
				if(mysql_num_rows($resultCheck) > 0) {
					$resultDelete = parent::doDelete($condition, $this -> _table);
				} else {
					$resultDelete = true;
				}
				
				if($resultDelete) {
					$resultUpdate = parent::doInsert($addressFinalArray, $this -> _table);
					
					if($resultUpdate != true) {
						$ctrl = false;
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
