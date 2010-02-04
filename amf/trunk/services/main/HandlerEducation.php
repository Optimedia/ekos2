<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	class HandlerEducation extends SqlManager {
		
		private $_table = "eko_detail_education";
		
		public function HandlerEducation() {
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
			
			$arrayEducation = array();
			
			while($education = mysql_fetch_object($result, "EducationVO")) {
				$arrayEducation[] = $education;
			}
			
			return $arrayEducation;
			
		}
		
		/**
		 * Fun��o para atualizar um cadastro na tabela 'eko_profile'
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param CompleteUserVO
		 */
		public function doUpdate(CompleteUserVO $value) {
			
			$education = new EducationVO();
			$educationArray = $value -> educationArray;

			foreach($educationArray as $education) {
				$educationFinalArray = array ('profile_id' => $_SESSION['account_id'],
									   		  'detail_education_level_id' => $education -> detail_education_level_id,
									   		  'institution' => $education -> institution,
									   		  'year' => $education -> year,
									   		  'status' => $education -> status,
							    	   		  'course' => $education -> course,
									   		  'title' => $education -> title);
				
				// Verificando se já está cadastrado.
				$condition = "profile_id=".$_SESSION['account_id']." AND detail_education_level_id=".$education -> detail_education_level_id;
				
				$sqlCheck = "SELECT * FROM ". $this -> _table ." WHERE ".$condition;
				$resultCheck = parent::doSelect($sqlCheck);
				
				if(mysql_num_rows($resultCheck) > 0) {
					$resultDelete = parent::doDelete($condition, $this -> _table);
				} else {
					$resultDelete = true;
				}
				
				if($resultDelete) {
					$resultUpdate = parent::doInsert($educationFinalArray, $this -> _table);
				}
				
			}
			
			return $resultUpdate;
		}
		
	}
	
?>
