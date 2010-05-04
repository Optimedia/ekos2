<?php
require_once '../includes/SqlManager.php';
require_once '../vo/br/com/optimedia/assets/vo/SubjectVO.php';
require_once '../vo/br/com/optimedia/assets/vo/PresentationVO.php';
require_once '../vo/br/com/optimedia/assets/vo/SlideVO.php';
require_once '../vo/br/com/optimedia/assets/vo/SkinVO.php';
require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';

class SubjectManager extends SqlManager {
	
	private $_table = "ath_subject";
	
	public function SubjectManager() {
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
		
		parent::SqlManager ( $host, $user, $pass, $db );
	}
	
	/**
	 * Função que retorna todos os m�dulos
	 *  
	 * - Retorna: Array - SubjectVO
	 * .
	 */
	public function getSubjects($userID) {

		if( $userID != 0 ) {
			
			$sql = "SELECT s.* FROM ath_subject s, ath_subject_user su WHERE s.subject_id=su.subject_id AND su.user_id=$userID ORDER BY subject_id";
			$query = parent::doSelect ( $sql );
			
			$subject = new SubjectVO ( );
			$subjectArray = array ();
			
			while ( $subject = mysql_fetch_object ( $query, "SubjectVO" ) ) {
				$subjectArray [] = $subject;
			}
			
			foreach ( $subjectArray as $subject ) {
				$subject->presentationArray = $this->getPresentation ( $subject->subject_id );
			}
		}
		else {
			$sql = "SELECT * FROM ath_subject ORDER BY subject_id";
			$query = parent::doSelect ( $sql );
			
			$subject = new SubjectVO ( );
			$subjectArray = array ();
			
			while ( $subject = mysql_fetch_object ( $query, "SubjectVO" ) ) {
				$subjectArray [] = $subject;
			}
			
			foreach ( $subjectArray as $subject ) {
				$subject->presentationArray = $this->getPresentation ( $subject->subject_id );
			}
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
		$query = parent::doSelect ( $sql );
		
		$presentation = new PresentationVO ( );
		$presentationArray = array ();
		
		while ( $presentation = mysql_fetch_object ( $query, "PresentationVO" ) ) {
			$presentationArray [] = $presentation;
		}
		
		foreach ( $presentationArray as $presentation ) {
			$presentation->slidesArray = $this->getSlides ( $presentation->presentation_id );
		}
		
		return $presentationArray;
	}

	public function getPlayerSlides($presentationID) {
		require_once "SlideManager.php";
		$slideManager = new SlideManager ( );
		return $slideManager->getPlayerSlides ( $presentationID );
	}
	
	public function getSlides($presentationID) {
		require_once "SlideManager.php";
		$slideManager = new SlideManager ( );
		return $slideManager->getSlides ( $presentationID );
	}
	
	public function getSlide($slideID) {
		require_once "SlideManager.php";
		$slideManager = new SlideManager ( );
		return $slideManager->getSlide ( $slideID );
	}
	
	/**
	 * Função que retorna todos os skins
	 *  
	 * - Retorna: Array - SkinVO
	 * .
	 */
	public function getSkins() {
		
		$sql = "SELECT * FROM ath_skin ORDER BY title";
		$query = parent::doSelect ( $sql );
		
		$skin = new SkinVO ( );
		$skinArray = array ();
		
		while ( $skin = mysql_fetch_object ( $query, "SkinVO" ) ) {
			$skinArray [] = $skin;
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
		
		if ($subject->title != "" && $subject->description != "") {
			
			// Montando array para inserir ou atualizar.
			$arraySubject = array ('title' => $subject->title, 'description' => $subject->description, 'status' => $subject->status );
			
			if ($subject->subject_id == 0) {
				
				// Verificar labels
				$sql = "SELECT subject_id FROM " . $this->_table . " WHERE subject_id=" . $subject->subject_id;
				$resultTemp = parent::doSelect ( $sql );
				
				if (mysql_num_rows ( $resultTemp ) > 0) {
					return false;
				}
				
				return parent::doInsert ( $arraySubject, $this->_table );
			
			} else {
				
				$condition = "subject_id = " . $subject->subject_id;
				
				return parent::doUpdate ( $arraySubject, $condition, $this->_table );
			
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
		
		if ($presentation->title != "" && $presentation->description != "") {
			
			// Montando array para inserir ou atualizar.
			$arrayPresentation = array ('subject_id' => $presentation->subject_id, 'skin_id' => $presentation->skin_id, 'title' => $presentation->title, 'description' => $presentation->description, 'status' => $presentation->status );
			
			if ($presentation->presentation_id == 0) {
				
				// Verificar labels
				$sql = "SELECT subject_id FROM ath_presentation WHERE 
					subject_id=" . $presentation->subject_id . " AND title='" . $presentation->title . "'";
				$resultTemp = parent::doSelect ( $sql );
				
				if (mysql_num_rows ( $resultTemp ) > 0) {
					return false;
				}
				
				// Adicionar presentation no bd;								  
				if (parent::doInsert ( $arrayPresentation, "ath_presentation" )) {
					$arraySlide = array ("type_slide_id" => 2, "presentation_id" => $this->insert_id, "header_id" => 1, "page_order" => 0, "title" => 'Título', "title_menu" => '', "text_body" => '', "status" => 0 );
					return parent::doInsert ( $arraySlide, "ath_slide" );
				}
				
				return false;
			
			} else {
				
				// Verificar se a presentation está liberada, se sim, atualizar os dados, se não retornar false;
				//					$tempPresentation = new PresentationVO();
				//					
				//					$fields = "locked_by";
				//					$table = "ath_presentation";
				//					$where = "presentation_id = ".$presentation -> presentation_id;
				//					$return = "object";
				//					$complement = "PresentationVO"; 
				//					
				//					$tempPresentation = parent::doSingleSelect($fields, $table, $where, null, $return, $complement);
				

				// Verificando se a presentation está liberada.
				//if($tempPresentation -> locked_by == null and $tempPresentation -> locked_at == null) {
				$sql = "SELECT * FROM ath_presentation WHERE presentation_id=" . $presentation->presentation_id;
				$query = $this->doSelect ( $sql );
				
				$presentationVO = mysql_fetch_object ( $query, "PresentationVO" );
				
				if ($presentationVO->locked_by == 0 || $presentationVO->locked_by == $userID) {
					$locked = false;
				} else {
					$locked = true;
				}
				
				if ($locked == false) {
					$condition = "presentation_id =" . $presentation->presentation_id;
					
					// Atualizar presentation no bd;
					return parent::doUpdate ( $arrayPresentation, $condition, "ath_presentation" );
				
				} else {
					return $presentationVO->first_name . " " . $presentationVO->last_name;
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
		
		$query = mysql_query ( $sql );
		
		$fields = "subject_id";
		$table = "ath_presentation";
		$where = "subject_id = " . $subject_id;
		
		$result = parent::doSingleSelect ( $fields, $table, $where );
		
		if (mysql_num_rows ( $result ) > 0) {
			return false;
		} else {
			
			// Deletar subject
			$condition = "subject_id=$subject_id";
			
			return parent::doDelete ( $condition, $this->_table );
		
		}
	
	}
	
	public function deletePresentation($presentation_id) {
		$condition = "presentation_id=$presentation_id";
		
		$result = parent::doDelete ( $condition, "ath_presentation" );
		
		$condition = "presentation_id=$presentation_id";
		
		if($result == true) {
			return parent::doDelete($condition, "ath_slide");
		} else {
			return false;
		}
	}
	
	public function publishPresentation($presentationID, $sectionID, $presentationName) {
		
		$array = array ('section_id' => $sectionID );
		
		$condition = "presentation_id =" . $presentationID;
		
		if (parent::doUpdate ( $array, $condition, "ath_presentation" ) == true) {
			require_once 'ResourceHandler.php';
			$resourceHandler = new ResourceHandler ( );
			return $resourceHandler->insertResource ( $presentationID, $sectionID, $presentationName );
		}
	}
	
	public function unpublishPresentation($presentationID, $sectionID) {
		$array = array ('section_id' => 0 );
		
		$condition = "presentation_id = " . $presentationID;
		
		if (parent::doUpdate ( $array, $condition, "ath_presentation" ) == true) {
			require_once 'ResourceHandler.php';
			$resourceHandler = new ResourceHandler ( );
			return $resourceHandler->removeResource ( $sectionID, $presentationID );
		}
	}
	
	public function getSections() {
		
		$sql = "SELECT * FROM ath_section ORDER BY title";
		$query = parent::doSelect ( $sql );
		
		$sectionArray = array ();
		
		while ( $section = mysql_fetch_object ( $query ) ) {
			$sectionArray [] = $section;
		}
		
		return $sectionArray;
	}
	
	public function lockPresentation($presentationID, $userID) {
		$sql = "SELECT * FROM ath_presentation WHERE presentation_id=$presentationID";
		$query = $this->doSelect ( $sql );
		
		$presentationVO = mysql_fetch_object ( $query, "PresentationVO" );
		
		if ($presentationVO->locked_by == 0 || $presentationVO->locked_by == $userID) {
			$locked = false;
		} else {
			$locked = true;
		}
		
		if ($locked == false) {
			/*$array = array ('locked_by' => $userID,
								'locked_at' => 'NOW()');
					
				$condition = "presentation_id = ".$presentationID;*/
			
			$sql = "UPDATE ath_presentation SET locked_at = NOW(), locked_by = $userID WHERE presentation_id = $presentationID";
			
			return mysql_query ( $sql );
			
		//return parent::doUpdate($array, $condition, "ath_presentation");
		} else {
			
			$sql1 = "SELECT * FROM eko_user WHERE user_id=" . $presentationVO->locked_by;
			$query1 = $this->doSelect ( $sql1 );
			
			$userVO = mysql_fetch_object ( $query1, "CompleteUserVO" );
			
			return $userVO->first_name . " " . $userVO->last_name;
		}
	}
	
	public function unlockPresentation($presentationID) {
		$sql = "UPDATE ath_presentation SET locked_at = NOW(), locked_by = 0 WHERE presentation_id = $presentationID";
		
		return mysql_query ( $sql );
	}
}