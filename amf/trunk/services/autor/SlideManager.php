<?php
	require_once '../vo/br/com/optimedia/assets/vo/SlideVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/SkinVO.php';

	class SlideManager extends SqlManager {
		
		public function SubjectManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Função que retorna todos as medias de uma presentation
		 *  
		 * - Retorna: Array - MediaVO
		 * .
		 */
		public function getSlides($presentationID) {
			
			$sql = "SELECT * FROM ath_subject ORDER BY subject_id";
			$query = parent::doSelect($sql);
			
			$subject = new SubjectVO();
			$subjectArray = array();
			
			while($subject = mysql_fetch_object($query, "SubjectVO")) {
				$subjectArray[] = $subject;
			}
			
			foreach($subjectArray as $subject) {
				$subject->presentationArray = $this->getPresentation($subject->subject_id);
			}
			
			return $subjectArray;
		}