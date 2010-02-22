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
				$slide->slideArray = $this->getMedias($slide->slide_id);
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
			
			foreach($allSlides as $value) {
				$slide_id = $value['slide_id'];
				$order = $value['order'];
				
				$tempArray = array("order" => $order);
				$condition = "slide_id=$slide_id";
				
				$result = parent::doUpdate($tempArray, $condition, $this -> _table);
				
				if($result != true) {
					return false;
				}
			}
			
			return true;
			
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

			// TO DO SALVAR mediaArray
			
			if($slide -> slide_id == 0) {
				return parent::doInsert($arrayTemp, $this -> _table);
			} else {
				
				$condition = "slide_id=".$slide -> slide_id;
				
				return parent::doUpdate($arrayTemp, $condition, $this -> _table);
				
			}
		}
		
		public function saveMedia(MediaVO $media) {
			
			$arrayTempMDA = array("media_id" => $media -> media_id,
							   "category_id" => $media -> category_id,
							   "title" => $media -> title,
							   "description" => $media -> description,
							   "creation" => $media -> creation,
							   "last_change" => $media -> last_change,
							   "body" => $media -> body,
							   "status" => $media -> status);
			
			$arrayTempATH = array("media_id" => $media -> media_id,
							   "slide_id" => $media -> slide_id);
			

			if($media -> media_id == 0) {
				if( parent::doInsert($arrayTempMDA, "mda_media") == true ) {
					return parent::doInsert($arrayTempATH, "ath_link");
				}
			} else {
				
				$condition = "slide_id=".$slide -> slide_id;
				
				if( parent::doUpdate($arrayTempMDA, $condition, "mda_media") == true ) {
					return parent::doUpdate($arrayTempATH, $condition, "ath_link");
				}
				
			}
		}
	}