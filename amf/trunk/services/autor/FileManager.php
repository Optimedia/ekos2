<?php

	class FileManager {
		
		public function upload(FileVO $file, $presentationID) { 
			$data = $file->filedata->data;
			$filename = 'presentationFiles/' . $presentationID . $file->filename;
			file_put_contents( $filename, $data);
			return $filename;
		}
	}