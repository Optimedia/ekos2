<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/FileVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/MediaVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/QuestionItemVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/QuestionVO.php';

	class RepositoryManager extends SqlManager {
		
		private $_table = "mda_media";
		
		public function RepositoryManager() {
			$this->setDataBase();
		}
		
		private function setDataBase() {
			if($_SERVER['SERVER_ADDR'] == "174.122.24.74") {
				$host = "localhost";
				$user = "root";
				$pass = "p0lyd4m4sSQL";
				$db = "ekos2_sinase2";
			} else {
				$host = "10.1.1.10";
				$user = "opti";
				$pass = "opti";
				$db = "ekos2_sinase2";
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
			
			$this->resizeImg ($presentationID . '/' . $filename);
				
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
			
			//$finalName = preg_replace( "/[^aA-zZ0-9\-_\.]+/i", "", $file->filename);
			$finalName = substr($file->filename, strlen($file->filename)-4, 4);

			$filename = mt_rand() . mt_rand() . $finalName;
			file_put_contents( 'mediafiles/' . $filename, $data);
			
			$this->resizeImg ('mediafiles/' . $filename);
			
			
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
		
		if ($media -> media_id != 0 ) {
					
			$condition = "media_id = ". $media ->media_id;
					
			if( parent::doUpdate($arrayMedia, $condition , 'mda_media')) {
					return true;
			}
			
				
		} else if( parent::doInsert($arrayMedia, $this -> _table) == true ) {
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
			
			//return $media->media_id; 
			
			if($media->media_id==0) {
				
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
												
						foreach ($question -> itemArray as $questionItem ) {
							
							if($questionItem-> correct_answer==false){
								$questionItem -> correct_answer="false";
							}else {
								$questionItem->correct_answer="true";
							}

							if (!$this -> saveQuestionItem($mediaID, $questionItem)) {
									
									$this-> deleteMedia($mediaID);
									$this-> deleteQuestionItem ($mediaID);
									
									return false;
								}
						}
						return "Questionario cadastrado com sucesso.";
					}
				}					 
			}else {
				
				$sql = "SELECT * FROM ath_link WHERE media_id=" . $media->media_id;
				$result = mysql_query($sql);
				
				// verificar se o midia esta sendo usado em mais de um lugar;
				// so apagar quando não esta sendo utilizado
				if(mysql_num_rows($result) > 0) {
					return "questionário sendo utilizado, não pode ser alterado";
				} else {
					$arrayMedia = array	('media_id' => $media ->media_id,
									 'title' => $question -> title,
								  	 'category_id' => $media -> category_id,
								  	 'description' => $question -> description,
								  	 'body' => $question -> comment,
									 'status' => 1);
									 
									 
					$condition = "media_id = ". $media ->media_id;
					$mediaID = $media->media_id;
					
					$this-> deleteQuestionItem ($mediaID);	
					
					if( parent::doUpdate($arrayMedia, $condition , 'mda_media')) {
						
						foreach ($question -> itemArray as $questionItem ) {	
							
							if($questionItem-> correct_answer==false){
								$questionItem -> correct_answer="false";
							}else {
								$questionItem->correct_answer="true";
							}				
							if (!$this -> saveQuestionItem($mediaID, $questionItem)) {
								$this-> deleteQuestionItem ($mediaID);
								return false;
							}
						}
						return "Questão alterado com sucesso. ";
	
					}
				}
				
			}
			return false;
		}
		private function saveQuestionItem ($mediaID, QuestionItemVO $questionItem) {
								
			
			if($questionItem-> question_item_id>=1) {									
				$array = array	(	
								'question_item_id'=>$questionItem ->question_item_id,   
								'name' => $questionItem -> name,
						 		'correct_answer' => $questionItem -> correct_answer,
						  	 	'media_id' => $mediaID);
						  	 	
			} else {
				$array = array	(	
								'name' => $questionItem -> name,
						 		'correct_answer' => $questionItem -> correct_answer,
						  	 	'media_id' => $mediaID);
				
			}
			
				
			if (parent::doInsert($array, "ath_question_item")){
				// ###############################################################
				// LOG
				if($questionItem-> question_item_id>=1) {
					$arrayLog = array ('user_id' => $_SESSION['userID'], 
													'question_item_id' => $questionItem ->question_item_id,
													'media_id'=> $mediaID,
													'type_event' => 3 );
				} else {
					$questionItemID = $this->insert_id;
					$arrayLog = array ('user_id' => $_SESSION['userID'], 
													'question_item_id' => $questionItemID,
													'media_id'=> $mediaID,
													'type_event' => 1 );
				}									
				parent::doInsert ( $arrayLog, 'ath_log_question_item' );
				//return false;
				//FIM LOG
				// ###############################################################
				
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
							$arrayLog = array ('user_id' => $_SESSION['userID'], 
												'question_item_id' => $item, 
												'media_id'=> $media_id,
												'type_event' => 2 );
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
		public function getQuestion(MediaVO $media) {
		//public function getQuestion() {	
			
			 
			$question = new QuestionVO();
			$question->title = $media->title;
			$question->description = $media->description;
			$question->comment = $media->body;
			$question->question_id = $media->media_id;
			
			
			$sql = "SELECT * FROM ath_question_item where media_id = " . $media -> media_id;
			
			$result = parent::doSelect($sql);
			
			$array = array();
			$item = new QuestionItemVO();
				
			while($item = mysql_fetch_object($result, "QuestionItemVO")) {
				if($item->correct_answer=="false"){
					$item->correct_answer=false;
				}else {
					$item->correct_answer=true;
				}
				$array[] = $item;
			}	
			$question->itemArray = $array;
			
			return $question;	
		}
		//########### resize img
		public function resizeImg ($file){
			
			$tipo =  exif_imagetype ($file);
			/*
			Tipos da img
			 	1	IMAGETYPE_GIF
				2	IMAGETYPE_JPEG
				3	IMAGETYPE_PNG
				4	IMAGETYPE_SWF
				5	IMAGETYPE_PSD
				6	IMAGETYPE_BMP
				7	IMAGETYPE_TIFF_II (intel byte order)
				8	IMAGETYPE_TIFF_MM (motorola byte order)
				9	IMAGETYPE_JPC
				10	IMAGETYPE_JP2
				11	IMAGETYPE_JPX
				12	IMAGETYPE_JB2
				13	IMAGETYPE_SWC
				14	IMAGETYPE_IFF
				15	IMAGETYPE_WBMP
				16	IMAGETYPE_XBM
*/
			
			if (($tipo == 9) || ($tipo == 2) || ($tipo == 3)){
					
				$maxWidth = 700;
				$maxHeight = 2000;
				
				if ($tipo == 3) {
					$img = imagecreatefrompng($file);
				}else {
			     	$img = imagecreatefromjpeg($file);
				}  
			      $width = imagesx( $img );
			      $height = imagesy( $img );
				  
			      // calculate thumbnail size
			      if ($width>$maxWidth) {
				      $new_width = $maxWidth;
				      $new_height = floor( $height * ( $maxWidth / $width ));
			      }
			      if ($new_height>$maxHeight){
				      $new_width = floor( $width * ( $maxHeight / $height ));
				      $new_height = $maxHeight;		      	
			      }
			
			      // create a new temporary image
				if(($maxWidth < $width) || ($maxHeight < $height)) {
			    	$tmp_img = @imagecreatetruecolor( $new_width, $new_height );
				    // copy and resize old image into new image
				    imagecopyresized( $tmp_img, $img, 0, 0, 0, 0, $new_width, $new_height, $width, $height );
				
				      // save thumbnail into a file
				     if ($tipo == 3) {
				     	imagepng( $tmp_img, $file);
				     }else {
				      	imagejpeg( $tmp_img, $file);
				     }
				}else {
					return false;
				}
			}
			return true;
		}
		
		public function getAllImgs( $subject_id ) {
			
			$sql = "SELECT m.* FROM mda_media m, ath_media a WHERE m.category_id=3 AND a.media_id=m.media_id AND a.subject_id=$subject_id";
			
			$result = parent::doSelect($sql);
			$array = array();
			$media = new MediaVO();
			
			while($media = mysql_fetch_object($result, "MediaVO")) {
				$array[] = $media;
			}	
			
			return $array;
		}
	}