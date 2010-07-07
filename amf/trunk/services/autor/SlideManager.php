<?php

require_once '../includes/SqlManager.php';
require_once '../vo/br/com/optimedia/assets/vo/SlideVO.php';
require_once '../vo/br/com/optimedia/assets/vo/MediaVO.php';
require_once '../vo/br/com/optimedia/assets/vo/PresentationVO.php';
require_once '../vo/br/com/optimedia/assets/vo/SlideCommentVO.php';
require_once '../vo/br/com/optimedia/assets/vo/QuestionVO.php';
require_once '../vo/br/com/optimedia/assets/vo/QuestionItemVO.php';

class SlideManager extends SqlManager {
	
	private $_table = "ath_slide";
	
	public function SlideManager() {
		if($_SERVER['SERVER_ADDR'] == "174.122.24.74") {
			$host = "localhost";
			$user = "root";
			$pass = "p0lyd4m4sSQL";
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
	 * Função que retorna todos os slides
	 *  
	 * - Retorna: Array - SlideVO
	 * .
	 */
	public function getPlayerSlides($presentationID) {

		$slideArray = array ();

		$sql = "SELECT * FROM ath_presentation WHERE presentation_id = $presentationID";
		$query = parent::doSelect ( $sql );
		$presentation = mysql_fetch_object ( $query, "PresentationVO" );

		if ($presentation->img_credit) {
			$slide = new SlideVO ( );
			$slide->slide_id        = "-3";
			$slide->type_slide_id   = 3;
			$slide->presentation_id = $presentationID;
			$slide->header_id       = 1;
			$slide->page_order      = 0;
			$slide->title           = "Crédito";
			$slide->title_menu      = "Crédito";
			$slide->text_body       = $presentation->img_credit;
			$slide->status          = "1";
			$slideArray [] = $slide;		
		}
		
		$slide = new SlideVO ( );
		$slide->slide_id        = "-2";
		$slide->type_slide_id   = 1;
		$slide->presentation_id = $presentationID;
		$slide->header_id       = 1;
		$slide->page_order      = 0;
		$slide->title           = $presentation->title;
		$slide->title_menu      = $presentation->title;
		$slide->text_body       = $presentation->description;
		$slide->status          = "1";
		$slideArray [] = $slide;
		
		if ($presentation->img_intro) {
			$slide = new SlideVO ( );
			$slide->slide_id        = "-3";
			$slide->type_slide_id   = 3;
			$slide->presentation_id = $presentationID;
			$slide->header_id       = 1;
			$slide->page_order      = 0;
			$slide->title           = "Introdução";
			$slide->title_menu      = "Introdução";
			$slide->text_body       = $presentation->img_intro;
			$slide->status          = "1";
			$slideArray [] = $slide;		
		}
		
		$sql = "SELECT * FROM ath_slide WHERE presentation_id = $presentationID ORDER BY page_order";
		$query = parent::doSelect ( $sql );

		while ( $slide = mysql_fetch_object ( $query, "SlideVO" ) ) {
			$slide->mediaArray = $this->getMedias ( $slide->slide_id );
			$slideArray [] = $slide;
		}
		
		if ($presentation->img_conclusion) {
			$slide = new SlideVO ( );
			$slide->slide_id        = "-3";
			$slide->type_slide_id   = 3;
			$slide->presentation_id = $presentationID;
			$slide->header_id       = 1;
			$slide->page_order      = 0;
			$slide->title           = "Conclusão";
			$slide->title_menu      = "Conclusão";
			$slide->text_body       = $presentation->img_conclusion;
			$slide->status          = "1";
			$slideArray [] = $slide;		
		}
		
		return $slideArray;
	}

	public function getSlides($presentationID) {

		$slideArray = array ();
	
		$sql = "SELECT * FROM ath_slide WHERE presentation_id = $presentationID ORDER BY page_order";
		$query = parent::doSelect ( $sql );

		while ( $slide = mysql_fetch_object ( $query, "SlideVO" ) ) {
			$slide->mediaArray = $this->getMedias ( $slide->slide_id );
			$slideArray [] = $slide;
		}
		
		return $slideArray;
	}

	public function getSlide($slideID) {
		
		$sql = "SELECT * FROM ath_slide WHERE slide_id = $slideID";
		$query = parent::doSelect ( $sql );
		
		$slide = new SlideVO ( );
		//$slideArray = array ();
		
		$slide = mysql_fetch_object ( $query, "SlideVO" );
		$slide->mediaArray = $this->getMedias($slide->slide_id);
		return $slide;
		
	}
	
	/**
	 * Função que retorna todos as medias do slide
	 *  
	 * - Retorna: Array - MediaVO
	 * .
	 */
	public function getMedias($slideID) {
		
		$sql = "SELECT m.* FROM mda_media m, ath_link a WHERE a.slide_id=$slideID AND a.media_id=m.media_id";
		$query = parent::doSelect ( $sql );
		
		$media = new MediaVO ( );
		$mediaArray = array ();
		
		while ( $media = mysql_fetch_object ( $query, "MediaVO" ) ) {
			$mediaArray [] = $media;
		}
		
		return $mediaArray;
	}
	
	public function setOrder($allSlides) {
		
		foreach( $allSlides as $slide ) {
			$slide = $this->correctSlideName( $slide );
			$this->saveSlide( $slide );
			$presentationID = $slide->presentation_id;
		}
		
		// ###############################################################
		// LOG
		$arrayLog = array ('user_id' => $_SESSION['userID'], 'presentation_id' => $presentationID, 'type_event' => 3, 'description' => 'setOrder' );
		parent::doInsert ( $arrayLog, 'ath_log_presentation' );
		//FIM LOG
		// ###############################################################
		
		return $this->getSlides( $presentationID );
	}
	
	public function saveSlide(SlideVO $slide) {
		
		$arrayTemp = array ("type_slide_id" => $slide->type_slide_id, "presentation_id" => $slide->presentation_id, "header_id" => $slide->header_id, "page_order" => $slide->page_order, "title" => $slide->title, "title_menu" => $slide->title_menu, "text_body" => $slide->text_body, "status" => $slide->status );
		
		if ($slide->slide_id == 0) {
			
			$allSlides = array();
			$allSlides = $this->getSlides( $slide->presentation_id );
			$currentPage = $slide->page_order;
			
			//move os slides necessários para frente na page_order
			foreach ( $allSlides as $item ) {
				if( $item->page_order == $currentPage ) {
					$currentPage++;
					$item->page_order = $currentPage;
					
					$item = $this->correctSlideName( $item );
					
					$this->saveSlide( $item );
				}
			}

			if( parent::doInsert ( $arrayTemp, $this->_table ) ) {
				// ###############################################################
				// LOG
				$slideID = $this->insert_id;
				$arrayLog = array ('user_id' => $_SESSION['userID'], 'slide_id' => $slideID, 'type_event' => 1 );
				parent::doInsert ( $arrayLog, 'ath_log_slide' );
				//FIM LOG
				// ###############################################################
				return $this->getSlide( $slideID );
			}
			// para desfazer a movimentação dos slides caso não consiga inserir o novo slide
			else {
				$currentPage = $slide->page_order+1;
				foreach( $allSlides as $item ) {
					if( $item->page_order == $currentPage ) {
						$item->page_order = $currentPage-1;
						
						$item = $this->correctSlideName( $item );
						
						$this->saveSlide( $item );
						$currentPage++;
					}
				}
				return false;
			}
		} else {
			
			$condition = "slide_id=" . $slide->slide_id;
			$lastId = $slide->slide_id;
			
			$result = parent::doUpdate ( $arrayTemp, $condition, $this->_table );
			
			// ###############################################################
			// LOG
			$arrayLog = array ('user_id' => $_SESSION['userID'], 'slide_id' => $slide->slide_id, 'type_event' => 3 );
			parent::doInsert ( $arrayLog, 'ath_log_slide' );
			//FIM LOG
			// ###############################################################
			
			$where = "slide_id=$lastId";
			$table = "ath_link";
			
			$resultMedia = parent::doDelete($where, $table);
			
			if ($result != true || $resultMedia != true) {
				return false;
			}
			
			foreach ( $slide->mediaArray as $media_id ) {
				if( $media_id instanceof MediaVO ) {
					$media_id = $media_id->media_id;
				}
				$this->saveMediaLink ( $media_id, $lastId );
			}
			
			return $this->getSlide( $lastId );
		}
	}
	
	public function saveMediaLink($mediaID, $slideID) {
		
		$arrayTemp = array ("media_id" => $mediaID, "slide_id" => $slideID );
		
		return parent::doInsert ( $arrayTemp, "ath_link" );
	}
	
	public function deleteSlide(SlideVO $slide) {
		
		$where = "slide_id = $slide->slide_id";
		$table = "ath_slide";
		
		if( parent::doDelete ( $where, $table ) ) {
			// ###############################################################
			// LOG
			$arrayLog = array ('user_id' => $_SESSION['userID'], 'slide_id' => $slide->slide_id, 'type_event' => 2 );
			parent::doInsert ( $arrayLog, 'ath_log_slide' );
			//FIM LOG
			// ###############################################################
			$allSlides = $this->getSlides( $slide->presentation_id );
			$currentPage = $slide->page_order+1;
			foreach( $allSlides as $item ) {
				if( $item->page_order == $currentPage ) {
					$item->page_order = $currentPage-1;
					if( stripos($item->title, "Novo Slide ") === 0 ) {
						$item->title = "Novo Slide ".$item->page_order;
					}
					$this->saveSlide( $item );
					$currentPage++;
				}
			}

			$table1 = "ath_slide_comment";
			parent::doDelete ( $where, $table1 );
			
			return $this->getSlides( $slide->presentation_id );
		}
		else {
			return false;
		}
		
		//return parent::doDelete ( $where, $table );
	}
	
	//para corrigir os nomes dos slides com título não editado e deixar o número do slide = ao número
	//da page_order
	private function correctSlideName( $slide ) {
		if( stripos($slide->title, "Novo Slide ") === 0 ) {
			$slide->title = "Novo Slide ".$slide->page_order;
		}
		return $slide;
	}
	
	public function getSlideComments( $slideID ) {
		$sql = "SELECT * FROM ath_slide_comment WHERE slide_id=$slideID ORDER BY date ASC";
		$query = parent::doSelect ( $sql );
		
		$slideComment = new SlideCommentVO ( );
		$slideCommentArray = array ();
		
		while ( $slideComment = mysql_fetch_object ( $query, "SlideCommentVO" ) ) {
			
			$sql1 = "SELECT first_name, last_name FROM eko_user WHERE user_id = $slideComment->user_id";
			
			$query1 = parent::doSelect ( $sql1 );
			$user = mysql_fetch_assoc ( $query1 );
			
			$slideComment->user_name = $user['first_name'] . " " . $user['last_name'];
			
			$data = $slideComment->date;
			
			list ($ano,$mes,$dia,$hora,$minuto,$segundo) = split ('[-.:. ./]', $data);
			
			$slideComment->date = "$dia/$mes/$ano $hora:$minuto";
			
			$slideCommentArray [] = $slideComment;
		}
		
		return $slideCommentArray;
	}
	
	public function saveSlideComment(SlideCommentVO $comment) {
		
		$arrayTemp = array ("user_id" => $comment->user_id, "slide_id" => $comment->slide_id, "body" => $comment->body );
		
		return parent::doInsert ( $arrayTemp, "ath_slide_comment" );
		
	}
	
	public function deleteSlideComment( $commentID ) {
		
		$where = "slide_comment_id = $commentID";
		
		$table = "ath_slide_comment";
		
		return parent::doDelete ( $where, $table );
		
	}
	
	public function registerNavigation($userID, $presentationID, $slideID) {
		
		$arrayTemp = array ("user_id" => $userID, "presentation_id" => $presentationID, "slide_id" => $slideID );
		
		return parent::doInsert ( $arrayTemp, "ath_log_navigation" );
		
	}
	
	public function getLastViewedSlide($userID, $presentationID) {
		$slide = new SlideVO ( );
		
		$sql = "SELECT * FROM ath_log_navigation WHERE user_id=$userID AND presentation_id=$presentationID ORDER BY date DESC LIMIT 1";
		$query = parent::doSelect ( $sql );
		$result = mysql_fetch_assoc ( $query );

		if( $result ) {
			$sql = "SELECT * FROM ath_slide WHERE slide_id=".$result['slide_id'];
			$query = parent::doSelect ( $sql );
			
			$slide = mysql_fetch_object ( $query, "SlideVO" );
			
			if( $slide ) {
				return $slide;
			}
		}
		else {
			return false;
		}
	}
	public function getQuestion ($media_id) {
		$question = new QuestionVO();
		
		$sql = "SELECT * FROM mda_media WHERE media_id=$media_id";
		$result = mysql_query($sql);
		$result = mysql_fetch_array ( $result );
		
		$question->question_id = $media_id;
		$question->title = $result['title'];
		$question->description = $result['description'];
		$question->comment = $result['body'];
		
		$sql = "SELECT * FROM ath_question_item WHERE media_id=$media_id";
		$result = mysql_query($sql);
					
		$questionItem = array ();
		$questionItemVO = new QuestionItemVO();
		while ( $section = mysql_fetch_object ( $result , "QuestionItemVO" ) ) {
			if ($section->correct_answer == 1){
				$section->correct_answer = true;
			}else {
				$section->correct_answer = false;
			}
			$questionItem[] = $section;
			
		}
		$question -> itemArray = $questionItem;
		
		return 	$question;
	}
}
