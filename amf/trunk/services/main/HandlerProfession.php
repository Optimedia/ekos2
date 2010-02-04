<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	class HandlerProfession extends SqlManager {
		
		private $_table = "eko_detail_language";
		
		public function HandlerProfession() {
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
			
			$sql = "SELECT * FROM ".$this -> _table." WHERE profile_id="$_SESSION['account_id'];
			$result = parent::doSelect($sql);
			
			$arrayProfession = array();
			
			while($profession = mysql_fetch_object($result, "ProfessionVO")) {
				$arrayProfession[] = $profession;
			}
			
			return $arrayProfession;
			
		}
		
		/**
		 * Fun��o para atualizar um cadastro na tabela 'eko_profile'
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param CompleteUserVO
		 */
		public function doUpdate(CompleteUserVO $value) {
			
			$profession = new ProfessionVO();
			$professionArray = $value -> professionArray;

			foreach($professionArray as $profession) {
				$professionFinalArray = array ('profile_id' => $_SESSION['account_id'],
									   		   'company' => $profession -> company,
									   		   'position' => $profession -> position,
									   		   'description' => $profession -> description,
									   		   'country_name' => $profession -> country_name,
									   		   'state_name' => $profession -> state_name,
									   		   'city_name' => $profession -> city_name,
									   		   'begin_date' => $profession -> begin_date,
									   		   'end_date' => $profession -> end_date);
				
				// Verificando se já está cadastrado.
				$condition = "profile_id=".$_SESSION['account_id']." AND detail_professional_id=".$profession -> detail_professional_id;
				
				$sqlCheck = "SELECT * FROM ". $this -> _table ." WHERE ".$condition;
				$resultCheck = parent::doSelect($sqlCheck);
				
				if(mysql_num_rows($resultCheck) > 0) {
					$resultDelete = parent::doDelete($condition, $this -> _table);
				} else {
					$resultDelete = true;
				}
				
				if($resultDelete) {
					$resultUpdate = parent::doInsert($professionFinalArray, $this -> _table);
				}
				
			}
			
			return $resultUpdate;
		}
		
	}
