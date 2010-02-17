<?php
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/SubjectVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/PresentationVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/SlideVO.php';

	class SubjectManager extends SqlManager {
		
		public function SubjectManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Função que retorna todos os módulos
		 *  
		 * - Retorna: Array - SubjectVO
		 * .
		 */
		public function getSubjects() {
			
			$sql = "SELECT * FROM ath_subject";
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
		
		/**
		 * Função que retorna todos as presentation
		 *  
		 * - Retorna: Array - PresentationVO
		 * .
		 */
		public function getPresentation($subjectID) {
			
			$sql = "SELECT * FROM ath_presentation WHERE subject_id = $subjectID";
			$query = parent::doSelect($sql);
			
			$presentation = new PresentationVO();
			$presentationArray = array();
			
			while($presentation = mysql_fetch_object($query, "PresentationVO")) {
				$presentationArray[] = $presentation;
			}
			
			foreach($presentationArray as $presentation) {
				$presentation->slidesArray = $this->getSlides($presentation->presentation_id);
			}
			
			return $presentationArray;
		}
		
		/**
		 * Função que retorna todos os slides
		 *  
		 * - Retorna: Array - SlideVO
		 * .
		 */
		public function getSlides($presentationID) {
			
			$sql = "SELECT * FROM ath_slide WHERE presentation_id = $presentationID";
			$query = parent::doSelect($sql);
			
			$slide = new SlideVO();
			$slideArray = array();
			
			while($slide = mysql_fetch_object($query, "SlideVO")) {
				$slideArray[] = $slide;
			}
			
			return $slideArray;
		}
		
	}