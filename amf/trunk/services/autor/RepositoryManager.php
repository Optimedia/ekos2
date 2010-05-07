<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/FileVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/MediaVO.php';

	class RepositoryManager extends SqlManager {
		
		private $_table = "mda_media";
		
		public function RepositoryManager() {
			if($_SERVER['SERVER_ADDR'] == "74.54.27.146") {
				$host = "74.54.27.146:3309";
				$user = "root";
				$pass = "0pt1m3d14SQL";
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
			/*
			$sql = "SELECT m.* FROM mda_media m, ath_media a WHERE a.media_id=m.media_id AND a.presentation_id=$presentation_id";
			
			$result = parent::doSelect($sql);
			
			$arrayMedia = array();
			$media = new MediaVO();
			
			while($media = mysql_fetch_object($result, "MediaVO")) {
				$arrayMedia[] = $media;
			}
			
			return $arrayMedia;
			*/
			
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
			return parent::doUpdate($arrayPresentation, $condition, 'ath_presentation');
			
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
				
				return parent::doInsert($array, 'ath_media');
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
				
				return parent::doInsert($array, 'ath_media');
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
			
			if(mysql_num_rows($result) > 0) {
				return false;
			} else {
				
				$where = "media_id=$media_id";
				$table = "mda_media";
				
				return parent::doDelete($where, $table);
				
			}
			
		}
	}