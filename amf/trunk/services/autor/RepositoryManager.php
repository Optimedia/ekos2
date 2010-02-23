<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/FileVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/MediaVO.php';

	class RepositoryManager extends SqlManager {
		
		private $_table = "mda_media";
		
		public function RepositoryManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		public function getMedias($presentation_id) {
			
//			$sql = "SELECT m.* FROM mda_media m, ath_media a WHERE a.media_id=m.media_id AND a.presentation_id=$presentation_id";
//			
//			$result = parent::doSelect($sql);
//			
//			$arrayMedia = array();
//			$media = new MediaVO();
//			
//			while($media = mysql_fetch_object($result, "MediaVO")) {
//				$arrayMedia[] = $media;
//			}
//			
//			return $arrayMedia;
			
			
			$sql = "SELECT * FROM mda_category";
			$result = parent::doSelect($sql);
			
			$arrayMedia = array();
			$categoryArray = array();
			
			while($category = mysql_fetch_object($result)) {
				$sql1 = "SELECT m.* FROM mda_media m, ath_media a WHERE m.category_id=". $category->category_id ." AND a.media_id=m.media_id AND a.presentation_id=$presentation_id";
				
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
		
		public function uploadMediaFile(FileVO $file, MediaVO $media, $presentationID) {
			
			$data = $file->filedata->data;
			$filename = mt_rand() . $file->filename;
			file_put_contents( 'mediafiles/' . $filename, $data);
			
			$arrayMedia = array	('title' => $media -> title,
							  	 'category_id' => $media -> category_id,
							  	 'body' => $filename,
								 'status' => 1);
							  
			if( parent::doInsert($arrayMedia, $this -> _table) == true ) {
				$mediaID = parent::insert_id;
				$array = array	('media_id' => $mediaID,
								 'presentation_id' => $presentationID);
				
				return parent::doInsert($array, 'ath_media');
			}
			
			return false;
		}
		
		public function uploadMediaText(MediaVO $media) {
			
			$arrayMedia = array	('title' => $media -> title,
							  	 'category_id' => $media -> category_id,
							  	 'body' => $media -> body,
								 'status' => 1);
							  
			return parent::doInsert($arrayMedia, $this -> _table);
			
			//return $filename;
		}
		
		/**
		 * Fun��o para deletar uma media.
		 * 
		 * - Retorna: Boolean 
		 * .
		 */
		public function deleteMedia($mediaID) {
			
		}
	}