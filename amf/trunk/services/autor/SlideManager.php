<?php
	
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/SlideVO.php';
	
	class SlideManager extends SqlManager {
		
		private $_table = "ath_slide";
		
		public function SlideManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
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
			
			/*public $slide_id;
			public $type_slide_id;
			public $presentation_id;
			public $header_id;
			public $page_order;
			public $title;
			public $title_menu;
			public $text_body;
			public $status;*/
			
			if($slide_id == 0) {
				$arrayTemp = array("type_slide_id" => $slide -> type_slide_id,
								   "presentation_id" => $slide -> presentation_id,
								   "header_id" => $slide -> $header_id,
								   "page_order" => $slide -> $page_order,
								   "title" => $slide -> $title,
								   "title_menu" => $slide -> $title_menu,
								   "text_body" => $slide -> $text_body,
								   "status" => $slide -> status);
			}
		}
		
	}