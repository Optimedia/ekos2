<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/FileVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/MediaVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/QuestionItemVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/QuestionVO.php';

	class RepositoryManager extends SqlManager {
		
		private $_table = "mda_media";
		
		public function RepositoryManager() {
			if($_SERVER['SERVER_ADDR'] == "174.122.24.74") {
				$host = "localhost";
				$user = "root";
				$pass = "p0lyd4m4sSQL";
				$db = "ekos2";
			} else {
				$host = "10.1.1.10";
				$user = "opti";
				$pass = "opti";
				$db = "ekos2";
			}
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		public function getMedias($subject_id) {
			
			$sql = "SELECT * FROM mda_category";
			$result = parent::doSelect($sql);
			
			$arrayMedia = array();
			$categoryArray = array();
			
			while($category = mysql_fetch_object($result)) {
				$sql1 = "SELECT m.* FROM mda_media m, ath_media a WHERE m.category_id=". $category->category_id ." AND a.media_id=m.media_id AND a.subject_id=$subject_id";
				
				$result1 = parent::doSelect($sql1);
				$array = array();
				$media = new MediaVO();
				
				while($media = mysql_fetch_object($result1, "MediaVO")) {
					$array[] = $media;
				}	
				$category->children = $array;
				$categoryArray[] = $category;
			}
			return $categoryArray;
		}
		
		public function uploadPresentationFile(FileVO $file, $presentationID, $type) {
			
			$data = $file->filedata->data;
			$filename = $file->filename;
			chdir('presentationfiles');
			if( !is_dir($presentationID) ){
				mkdir($presentationID);
			}
			file_put_contents( $presentationID . '/' . $filename, $data);
			
			$arrayPresentation = array ($type => $filename);
			$condition = "presentation_id = ".$presentationID;
			if( parent::doUpdate($arrayPresentation, $condition, 'ath_presentation') ) {
				// ###############################################################
				// LOG
				$arrayLog = array ('user_id' => $_SESSION['userID'], 'presentation_id' => $presentationID, 'type_event' => 3, 'description' => 'uploadPresentationFile' );
				return parent::doInsert ( $arrayLog, 'ath_log_presentation' );
				//FIM LOG
				// ###############################################################
			}
			
			//return $filename;
		}
		
		public function uploadMediaFile(FileVO $file, MediaVO $media, $subject_id) {
			
			$data = $file->filedata->data;
			
			$finalName = preg_replace( "/[^aA-zZ0-9\-_\.]+/i", "", $file->filename);

			$filename = mt_rand() . $finalName;
			file_put_contents( 'mediafiles/' . $filename, $data);
			
			$arrayMedia = array	('title' => $media -> title,
							  	 'category_id' => $media -> category_id,
							  	 'body' => $filename,
								 'status' => 1);
							  
			//parent::doInsert($arrayMedia, $this -> _table);
			if( parent::doInsert($arrayMedia, $this -> _table) == true ) {
				$mediaID = $this->insert_id;
				
				$array = array	('media_id' => $mediaID,
								 'subject_id' => $subject_id);
				
				if( parent::doInsert($array, 'ath_media') ) {
					// ###############################################################
					// LOG
					$arrayLog = array ('user_id' => $_SESSION['userID'], 'media_id' => $mediaID, 'type_event' => 1 );
					return parent::doInsert ( $arrayLog, 'ath_log_media' );
					//FIM LOG
					// ###############################################################
				}
			}
			
			return false;
		}
		
		public function uploadMediaText(MediaVO $media, $subject_id) {
			
			$arrayMedia = array	('title' => $media -> title,
							  	 'category_id' => $media -> category_id,
							  	 'body' => $media -> body,
								 'status' => 1);
							  
			if( parent::doInsert($arrayMedia, $this -> _table) == true ) {
				$mediaID = $this->insert_id;
				
				$array = array	('media_id' => $mediaID,
								 'subject_id' => $subject_id);
				
				if( parent::doInsert($array, 'ath_media') ) {
					// ###############################################################
					// LOG
					$arrayLog = array ('user_id' => $_SESSION['userID'], 'media_id' => $mediaID, 'type_event' => 1 );
					return parent::doInsert ( $arrayLog, 'ath_log_media' );
					//FIM LOG
					// ###############################################################
				}
			}
			
			return false;
		}
		
		/**
		 * Fun��o para deletar uma media.
		 * 
		 * - Retorna: Boolean 
		 * .
		 */
		public function deleteMedia($media_id) {
			
			$sql = "SELECT * FROM ath_link WHERE media_id=$media_id";
			$result = mysql_query($sql);
			
			// verificar se o midia esta sendo usado em mais de um lugar;
			// so apagar quando não esta sendo utilizado
			if(mysql_num_rows($result) > 0) {
				return false;
			} else {
				
				$where = "media_id=$media_id";
				$table = "mda_media";
				
				if( parent::doDelete($where, $table) ) {
					
					$where = "media_id=$media_id";
					$table = "ath_media";
											
					parent::doDelete($where, $table);
					
						
					$this-> deleteQuestionItem($media_id);
					// ###############################################################
					// LOG
					$arrayLog = array ('user_id' => $_SESSION['userID'], 'media_id' => $media_id, 'type_event' => 2 );
					return parent::doInsert ( $arrayLog, 'ath_log_media' );
					//FIM LOG
					// ###############################################################
					
					
			
				}
			}
		}
		public function saveQuestion($media, $question, $subject_id) {

			$arrayMedia = array	('title' => $question -> title,
							  	 'category_id' => $media -> category_id,
							  	 'description' => $question -> description,
							  	 'body' => $question -> comment,
								 'status' => 1);
								 
			if( parent::doInsert($arrayMedia, "mda_media") == true ) {
				
					$mediaID = $this->insert_id;
				
					$array = array	('media_id' => $mediaID,
								 'subject_id' => $subject_id);
							
					
					if (parent::doInsert($array, 'ath_media')==true ){
						
						//$questionItem = new QuetionItemVO();
						
						foreach ($question -> itemArray as $questionItem ) {
							//return $this -> saveQuestionItem($mediaID, $questionItem);
							if (!$this -> saveQuestionItem($mediaID, $questionItem)) {
								
								$this-> deleteMedia($mediaID);
								$this-> deleteQuestionItem ($mediaID);
								
								return false;
							}
						}
						return true;
					}
			}
			return false;
		}
		private function saveQuestionItem ($mediaID, QuestionItemVO $questionItem) {
			
			$array = array	(   
						  	 	'name' => $questionItem -> name,
						  	 	'correct_answer' => $questionItem -> correct_answer,
						  	 	'media_id' => $mediaID);
		
			if (parent::doInsert($array, "ath_question_item")){
				return true;
			}else {
				return false;
			}
		}
		private function deleteQuestionItem ($media_id) {
			
			$sql = "SELECT * FROM ath_link WHERE media_id=$media_id";
			$result = mysql_query($sql);
			
			// verificar se o questionario esta sendo usado em mais de um lugar;
			// so apagar quando não esta sendo utilizado
			if(mysql_num_rows($result) > 0) {
				return false;
			} else {
				$sql = "SELECT * FROM ath_question_item WHERE media_id=$media_id";
				$result = mysql_query($sql);
				
				if(mysql_num_rows($result) > 0) {
					
					$questionItem = array ();
					while ( $section = mysql_fetch_array ( $result ) ) {
						$questionItem[] = $section["question_item_id"];
					}
					
					$where = "media_id=$media_id";
					$table = "ath_question_item";
					
					if( parent::doDelete($where, $table) ) {
						// ###############################################################
						// LOG
						foreach ($questionItem  as $item ) {	
							$arrayLog = array ('user_id' => $_SESSION['userID'], 'question_item_id' => $item, 'type_event' => 2 );
							parent::doInsert ( $arrayLog, 'ath_log_question_item' );
								//return false;
							//}
						}
						return true;
						//FIM LOG
						// ###############################################################
					}
				}
			}
		}
	}