<?php
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/SubjectVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/PresentationVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/SlideVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/SkinVO.php';

	class SubjectManager extends SqlManager {
		
		private $_table = "ath_subject";
		
		public function SubjectManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Função que retorna todos os m�dulos
		 *  
		 * - Retorna: Array - SubjectVO
		 * .
		 */
		public function getSubjects() {
			
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
		
		/**
		 * Função que retorna todos as presentation
		 *  
		 * - Retorna: Array - PresentationVO
		 * .
		 */
		public function getPresentation($subjectID) {
			
			$sql = "SELECT * FROM ath_presentation WHERE subject_id = $subjectID ORDER BY presentation_id";
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
			
			$sql = "SELECT * FROM ath_slide WHERE presentation_id = $presentationID ORDER BY page_order";
			$query = parent::doSelect($sql);
			
			$slide = new SlideVO();
			$slideArray = array();
			
			while($slide = mysql_fetch_object($query, "SlideVO")) {
				$slideArray[] = $slide;
			}
			
			return $slideArray;
		}
		
		/**
		 * Função que retorna todos os skins
		 *  
		 * - Retorna: Array - SkinVO
		 * .
		 */
		public function getSkins() {
			
			$sql = "SELECT * FROM ath_skin ORDER BY title";
			$query = parent::doSelect($sql);
			
			$skin = new SkinVO();
			$skinArray = array();
			
			while($skin = mysql_fetch_object($query, "SkinVO")) {
				$skinArray[] = $skin;
			}
			
			return $skinArray;
		}
		
		/**
		 * Função para inserir ou atualizar uma subject 
		 * 
		 * - Retorna: Boolean // Verificar se é igual a true | false = mysql_error();
		 * .
		 */
		public function saveSubject(SubjectVO $subject) {
			
			if($subject -> title != "" && $subject -> description != "") {
				if($subject -> subject_id == 0) {
					
					// Verificar labels
					$sql = "SELECT subject_id FROM ".$this -> _table." WHERE subject_id=".$subject -> subject_id;
					$resultTemp = parent::doSelect($sql);
					
					if(mysql_num_rows($resultTemp) > 0) {
						return false;
					}
					
					$arraySubject = array	('title' => $subject -> title,
										  	 'description' => $subject -> description,
											 'status' => $subject -> status);
									  
					return parent::doInsert($arraySubject, $this -> _table);
					
				} else {
					
					$arraySubject = array	('title' => $subject -> title,
										  	 'description' => $subject -> description,
											 'status' => $subject -> status);
						
					$condition = "subject_id = ".$subject -> subject_id;
					
					return parent::doUpdate($arraySubject, $condition, $this -> _table);
					
				}
			} else {
				return false;
			}
		}
		
		/**
		 * Função para inserir ou atualizar uma presentation
		 * 
		 * - Retorna: Boolean // Verificar se é igual a true | false = mysql_error();
		 * .
		 */
		public function savePresentation(PresentationVO $presentation) {
			
			/*$presentation = new PresentationVO();
			
			$presentation -> subject_id = 1;
			$presentation -> skin_id = 1;
			$presentation -> title = "teste";
			$presentation -> description = "teste";*/
			
			if($presentation -> title != "" && $presentation -> description != "") {
				if($presentation -> presentation_id == 0) {
					
					// Verificar labels
					$sql = "SELECT subject_id FROM ath_presentation WHERE subject_id=".$presentation -> subject_id." AND title!='".$presentation -> title."'";
					$resultTemp = parent::doSelect($sql);
					
					if(mysql_num_rows($resultTemp) > 0) {
						return false;
					}
					
					// Adicionar presentation no bd;
					$arrayPresentation = array	('subject_id' => $presentation -> subject_id,
												 'skin_id' => $presentation -> skin_id,
												 'title' => $presentation -> title,
												 'description' => $presentation -> description,
											 	 'status' => $presentation -> status);
								  
					return parent::doInsert($arrayPresentation, "ath_presentation");
					
				} else {
					
					
					
					// Verificar se a presentation está liberada, se sim, atualizar os dados, se não retornar false;
					$tempPresentation = new PresentationVO();
					
					$fields = "locked_by, locked_at";
					$table = "ath_presentation";
					$where = "presentation_id = ".$presentation -> presentation_id;
					$return = "object";
					$complement = "PresentationVO"; 
					
					$tempPresentation = parent::doSingleSelect($fields, $table, $where, null, $return, $complement);
					
					// Verificando se a presentation está liberada.
					if($tempPresentation -> locked_by == null and $tempPresentation -> locked_at == null) {
						
						$arrayPresentation = array	('subject_id' => $presentation -> subject_id,
													 'skin_id' => $presentation -> skin_id,
													 'title' => $presentation -> title,
													 'description' => $presentation -> description,
													 'status' => $presentation -> status);
						
						$condition = "presentation_id = ".$presentation -> presentation_id;
						
						return parent::doUpdate($arrayPresentation, $condition, $table);
						
					} else {
						return false;
					}
				}
			} else {
				return false;
			}
		}
		
		/**
		 * Função para deletar um Subject somente quando n�o houver mais Presentations
		 * 
		 * - Retorna: Boolean // Verificar se é igual a true | false = mysql_error();
		 */
		public function deleteSubject($subject_id) {
			
			// Verificar se há presentations ligadas a esse subject
			$sql = "SELECT subject_id FROM ath_presentation WHERE subject_id=$subject_id";
			
			$query = mysql_query($sql);
			
			$fields = "subject_id";
			$table = "ath_presentation";
			$where = "subject_id = ".$subject_id; 
				
			$result = parent::doSingleSelect($fields, $table, $where);
			
			
			if(mysql_num_rows($result) > 0) {
				return false;
			} else {
				
				// Deletar subject
				$condition = "subject_id=$subject_id";
				
				return parent::doDelete($condition, $this -> _table);
				
			}
			
		}
		
		public function deletePresentation($presentation_id) {
			$condition = "presentation_id=$presentation_id";
				
			return parent::doDelete($condition, "ath_presentation");
		}
	}