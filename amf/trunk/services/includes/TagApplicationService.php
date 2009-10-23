<?php
	
	require_once ('SqlManager.php');
	
	class TagApplicationService extends SqlManager {
		
		public function TagApplicationService()
		{
			parent::SqlManager("localhost", "root", "", "ekos");
		}
		
		public function doTagfier($tags, $table) {					
			$array = explode(" ",$tags);			
			foreach ($array as &$value){
				
				$data = array(
							"name" => $value,
							"count" => 1);
							
				parent::doInsert($data, $table);
				
			}	
		}
	}
	
	?>