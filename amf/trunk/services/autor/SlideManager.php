<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/SlideVO.php';
	require_once '../vo/br/com/optimedia/assets/vo/MediaVO.php';
	
	class SlideManager extends SqlManager {
		
		private $_table = "ath_slide";
		
		public function SlideManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
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
				$slide->mediaArray = $this->getMedias($slide->slide_id);
				$slideArray[] = $slide;
			}
			
			return $slideArray;
		}
		
		/**
		 * Função que retorna todos as medias do slide
		 *  
		 * - Retorna: Array - MediaVO
		 * .
		 */
		public function getMedias($slideID) {
			
			$sql = "SELECT m.* FROM mda_media m, ath_link a WHERE a.slide_id=$slideID AND a.media_id=m.media_id";
			$query = parent::doSelect($sql);
			
			$media = new MediaVO();
			$mediaArray = array();
			
			while($media = mysql_fetch_object($query, "MediaVO")) {
				$mediaArray[] = $media;
			}
			
			return $mediaArray;
		}
		
		public function setOrder($allSlides) {
			
			$presentation_id = 0;
			
			foreach($allSlides as $slide) {
				$slide_id = $slide -> slide_id;
				$order = $slide -> page_order;
				$presentation_id = $slide -> presentation_id;
				
				if($slide -> title == "" || $slide -> title == null) {
					$title = "Título";
				} else {
					$title = $slide -> title;
				}
				
				if($slide -> type_slide_id == 0) {
					$type_slide_id = 1;
				} else {
					$type_slide_id = $slide -> type_slide_id;
				}
				
				if($slide -> header_id == 0) {
					$header_id = 1;
				} else {
					$header_id = $slide -> header_id;
				}
				
				$tempArray = array("page_order" => $order,
								   "title" => $title,
								   "type_slide_id" => $type_slide_id,
								   "header_id" => $header_id);
				
				$condition = "slide_id=$slide_id";
				
				$result = parent::doUpdate($tempArray, $condition, $this -> _table);
				
				if($result != true) {
					return false;
				}
			}
			
			return $this -> getSlides($presentation_id);
			
		}
		
		public function saveSlide(SlideVO $slide) {
			
			$arrayTemp = array("type_slide_id" => $slide -> type_slide_id,
							   "presentation_id" => $slide -> presentation_id,
							   "header_id" => $slide -> header_id,
							   "page_order" => $slide -> page_order,
							   "title" => $slide -> title,
							   "title_menu" => $slide -> title_menu,
							   "text_body" => $slide -> text_body,
							   "status" => $slide -> status);
			
			if($slide -> slide_id == 0) {
				$result = parent::doInsert($arrayTemp, $this -> _table);
				$lastId = $this -> insert_id;
			} else {
				$condition = "slide_id=".$slide -> slide_id;
				$lastId = $slide -> slide_id;
				
				$result = parent::doUpdate($arrayTemp, $condition, $this -> _table);				
			}
			
			if($result != true) {
				return false;
			}
			
			// TO FINISH SALVAR mediaArray
			foreach($slide->mediaArray as $media) {
				$this->saveMediaLink( $media, $lastId );
			}
			
			return true;
			
		}
		
		public function saveMediaLink(MediaVO $media, $slideID) {
			
			$arrayTemp = array("media_id" => $media -> media_id,
							   "slide_id" => $slideID);

			if($slideID == 0) {

				return parent::doInsert($arrayTemp, "ath_link");

			} else {
				
				$condition = "slide_id=".$slideID;
				
				return parent::doUpdate($arrayTemp, $condition, "ath_link");
				
			}
		}
	}