<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	class HandlerLanguage extends SqlManager {
		
		private $_table = "eko_detail_language";
		
		public function HandlerLanguage() {
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
			
			$arrayLanguage = array();
			
			while($language = mysql_fetch_object($result, "LanguageVO")) {
				$arrayLanguage[] = $language;
			}
			
			return $arrayLanguage;
			
		}
		
		/**
		 * Fun��o para atualizar um cadastro na tabela 'eko_profile'
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param CompleteUserVO
		 */
		public function doUpdate(CompleteUserVO $value) {
			
			$language = new LanguageVO();
			$languageArray = $value -> languageArray;

			foreach($languageArray as $language) {
				$languageFinalArray = array ('profile_id' => $_SESSION['account_id'],
									   		  'detail_language_option_id' => $language -> detail_language_option_id,
									   		  'speech' => $language -> speech,
									   		  'writing' => $language -> writing,
									   		  'reading' => $language -> reading);
				
				// Verificando se já está cadastrado.
				$condition = "profile_id=".$_SESSION['account_id']." AND detail_language_option_id=".$language -> detail_language_option_id;
				
				$sqlCheck = "SELECT * FROM ". $this -> _table ." WHERE ".$condition;
				$resultCheck = parent::doSelect($sqlCheck);
				
				if(mysql_num_rows($resultCheck) > 0) {
					$resultDelete = parent::doDelete($condition, $this -> _table);
				} else {
					$resultDelete = true;
				}
				
				if($resultDelete) {
					$resultUpdate = parent::doInsert($languageFinalArray, $this -> _table);
				}
				
			}
			
			return $resultUpdate;
		}
		
	}
