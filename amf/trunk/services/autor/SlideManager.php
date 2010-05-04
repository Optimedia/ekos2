<?php

require_once '../includes/SqlManager.php';
require_once '../vo/br/com/optimedia/assets/vo/SlideVO.php';
require_once '../vo/br/com/optimedia/assets/vo/MediaVO.php';
require_once '../vo/br/com/optimedia/assets/vo/PresentationVO.php';

class SlideManager extends SqlManager {
	
	private $_table = "ath_slide";
	
	public function SlideManager() {
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
		
		return $this->getSlides( $presentationID );
		
//		$presentation_id = 0;
//		
//		foreach ( $allSlides as $slide ) {
//			$slide_id = $slide->slide_id;
//			$order = $slide->page_order;
//			$presentation_id = $slide->presentation_id;
//			
//			if ($slide->title == "" || $slide->title == null) {
//				$title = "Título";
//			} else {
//				$title = $slide->title;
//			}
//			
//			if ($slide->type_slide_id == 0) {
//				$type_slide_id = 1;
//			} else {
//				$type_slide_id = $slide->type_slide_id;
//			}
//			
//			if ($slide->header_id == 0) {
//				$header_id = 1;
//			} else {
//				$header_id = $slide->header_id;
//			}
//			
//			$tempArray = array ("page_order" => $order, "title" => $title, "type_slide_id" => $type_slide_id, "header_id" => $header_id );
//			
//			$condition = "slide_id=$slide_id";
//			
//			$result = parent::doUpdate ( $tempArray, $condition, $this->_table );
//			
//			if ($result != true) {
//				return false;
//			}
//		}
//		
//		return $this->getSlides ( $presentation_id );
	
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
				return $this->getSlide( $this->insert_id );
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
}
