<?php

	class FileUpload {
		
		public function upload(FileVO $file) { 
			$data = $file->filedata->data;
			file_put_contents( 'uploads/' . $file->filename, $data);
			return 'File: ' . $file->filename .' Uploaded '; 
		}
	}