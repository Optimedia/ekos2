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
		
		public function getBySessionId() {
			
			$sql = "SELECT * FROM ".$this -> _table." WHERE profile_id=".$_SESSION['account_id'];
			$result = parent::doSelect($sql);
			
			$arrayAddress = array();
			
			while($address = mysql_fetch_object($result, "AddressVO")) {
				$arrayAddress[] = $address;
			}
			
			return $arrayAddress;
			
		}
		
		
		/**
		 * Fun��o para atualizar um cadastro na tabela 'eko_profile'
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param CompleteUserVO
		 */
		public function doUpdate(CompleteUserVO $value) {
			
			$address = new AddressVO();
			$addressArray = $value -> addressArray;

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
				}
				
			}
			
			return $resultUpdate;
		}
		
	}
