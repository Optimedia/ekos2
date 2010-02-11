<?php
	
	require_once '../includes/SqlManager.php';

	class RepositoryManager extends SqlManager {
		
		public function RepositoryManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Função para fazer o upload da imagem do perfil.
		 * 
		 * - Retorna: String [filename]
		 * .
		 *
		 */
		public function uploadFile(FileVO $file) { 
			$data = $file->filedata->data;
			$filename = mt_rand() . $file->filename;
			file_put_contents( 'avatars/' . $filename, $data);
			createthumb("avatars/$filename","avatars/160x160/$filename", 160, 160);
			createthumb("avatars/$filename","avatars/100x100/$filename", 100, 100);
			return $filename;
		}
		
	}