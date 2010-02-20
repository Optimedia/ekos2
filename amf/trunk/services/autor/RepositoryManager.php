<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/FileVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/MediaVO.php';

	class RepositoryManager extends SqlManager {
		
		public function RepositoryManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
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
		
		public function uploadMediaFile(FileVO $file, MediaVO $media) {
			
			$data = $file->filedata->data;
			$filename = mt_rand() . $file->filename;
			file_put_contents( 'mediafiles/' . $filename, $data);
			
			$arrayMedia = array	('title' => $media -> title,
							  	 'category_id' => $media -> category_id,
							  	 'body' => $filename,
								 'status' => 1);
							  
			return parent::doInsert($arrayMedia, "mda_media");
			
			//return $filename;
		}
		
		public function uploadMediaText(MediaVO $media) {
			
			$arrayMedia = array	('title' => $media -> title,
							  	 'category_id' => $media -> category_id,
							  	 'body' => $media -> body,
								 'status' => 1);
							  
			return parent::doInsert($arrayMedia, "mda_media");
			
			//return $filename;
		}
	}