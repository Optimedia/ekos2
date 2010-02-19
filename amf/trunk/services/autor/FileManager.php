<?php
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/FileVO.php';

	class FileManager {
		
		public function FileManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		public function uploadPresentationFile(FileVO $file, $presentationID, $type) {
			
			$data = $file->filedata->data;
			$filename = $file->filename;
			file_put_contents( 'presentationFiles/' . $presentationID . '/' . $filename, $data);
			
			$arrayPresentation = array ($type => $filename);
			$condition = "presentation_id = ".$presentationID;
			return parent::doUpdate($arrayPresentation, $condition, 'ath_presentation');
			
			return $filename;
		}
	}