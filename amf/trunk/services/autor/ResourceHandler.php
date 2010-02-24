<?php
    require_once '../includes/SqlManager.php';

	class ResourceHandler extends SqlManager {
        
		protected $db_name = sinasemdl;
        protected $course = 2;
        protected $instances;
        protected $instancesModule;
        protected $sectionID;
        protected $presentationID;
        
		public function ResourceHandler() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "sinasemdl";
	
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		function insertResource($presentationID, $sectionID, $presentationName){
		    $this->sectionID = $sectionID;
		    $this->presentationID = $presentationID;
		    $fieldsAndValuesResource= array("course" => $this->course,
						                    "name" => $presentationName,
						                    "type" => "html",
						                    "reference" => "",
						                    "summary" => $presentationName,
						                    "alltext" => "<script src='/Interactive/includeAll.js' language='javascript'></script><noscript>  	<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000'			id='Interactive' width='800' height='512'			codebase='http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab'>			<param name='movie' value='Interactive.swf' />			<param name='quality' value='high' />			<param name='bgcolor' value='#869ca7' />			<param name='allowScriptAccess' value='sameDomain' />      <param name='flashVars' value='_presentation=$presentationID&_idSlide=0'/> 			<embed src='/Interactive/Interactive.swf' quality='high' bgcolor='#869ca7'				width='800' height='512' name='Interactive' align='middle'				play='true'				loop='false'				quality='high'				allowScriptAccess='sameDomain'				type='application/x-shockwave-flash'				pluginspage='http://www.adobe.com/go/getflashplayer'>			</embed>	</object></noscript>",
						                    "popup" =>"",
						                    "options" =>"",
						                    "timemodified" =>"1248132589"
											);
	    
	        $result = parent::doInsert($fieldsAndValuesResource,"mdl_resource");
	        
	        $this-> instances = $this->insert_id;
	        
	        $this->insertCourseModule();
			//return $this-> instancesResource;
			return $result;
	    }

		function insertCourseModule(){
		    $fieldsAndValuesResource= array("course" => "2",
						                    "module" => "13",
						                    "instance" => $this->instances,
						                    "section" => $this->sectionID,
						                    "idnumber" => "",
						                    "added" => "1248132589",
						                    "score" => "0",
						                    "indent" => "0",
						                    "visible" => "1",
						                    "visibleold" => "1",
						                    "groupmode" => "0",
						                    "groupingid" => "0",
						                    "groupmembersonly" => "0"
											);
		    
		    $result = parent::doInsert($fieldsAndValuesResource,"mdl_course_modules");
		    
		    $this-> instancesModule = $this -> insert_id;
		    
		    $fieldsAndValuesPresentation = array("module_id"=> $this-> instancesModule);

            $condition="presentation_id=$this->presentationID";
            
            $result = parent::doUpdate($fieldsAndValuesPresentation,$condition,"ekos2.ath_presentation");
            
		    $this-> insertContext();
		    
		    //return $result;
		}
		
		function insertContext() {
		    $fieldsAndValuesResource= array("contextlevel" => "70",
						                    "instanceid" => $this->instances,
						                    "path" => "/1/56/12/",
						                    "depth" => "4"
											);
		    
		    $result = parent::doInsert($fieldsAndValuesResource,"mdl_context");
		    
		    $this-> instances = $this -> insert_id;
		    
		    $fieldsAndValuesResource= array( "path" => "/1/56/12/$this->instances" );
		    
		    $condition = "id=$this->instances";
		    
		    $result = parent::doUpdate( $fieldsAndValuesResource, $condition, "mdl_context" );
		    
		    $this->insertCourseSection();
		    
		    //return $result;
		}
	
		function insertCourseSection() {
		    $fields="sequence";
	
		    $condition= "id=$this->sectionID";
		    
		    $result = parent::doSingleSelect($fields, "mdl_course_sections", $condition, null, "array", MYSQL_ASSOC);
		    
		    if(empty($result["sequence"])){
	            $fieldsAndValuesResource= array( "sequence" => $this->instancesModule );
		    }
		    
		    else {
			    $newSequence = $result["sequence"];
			    $newSequence.=",$this->instancesModule";
				$fieldsAndValuesResource= array( "sequence" => $newSequence );
		    }
			
		    $result = parent::doUpdate($fieldsAndValuesResource,$condition,"mdl_course_sections");
			
//		    $fieldsAndValuesResource= array( "section_id" => $this->sectionID );
//			
//		    $condition="presentation_id=$this->presentationID";
//			
//		    $result = parent::doUpdate( $fieldsAndValuesResource, $condition, "ekos2.ath_presentation" );
		}
		function removeResource($sectionID,$presentationID){

            $fieldPresentation="module_id";

            $conditionPresentation= "presentation_id=$presentationID";

            $resultModule = parent::doSingleSelect($fieldPresentation, "ekos2.ath_presentation", $conditionPresentation, null, "array", MYSQL_ASSOC);
            
            $fieldsSections ="sequence";

		    $conditionSections = "id=$sectionID";

		    $resultSections = parent::doSingleSelect($fieldsSections, "mdl_course_sections", $conditionSections, null, "array", MYSQL_ASSOC);
		    
		    $pieces = explode(",",$resultSections["sequence"]);
            
            $indice = array_search($resultModule["module_id"],$pieces);
            
            unset($pieces[$indice]);
            
            $union = implode(",",$pieces);
            
            $fieldsAndValuesSection= array("sequence" => $union);
            
            $condition = "id=$sectionID";
            
            $result = parent::doUpdate($fieldsAndValuesSection,$condition,"mdl_course_sections");

            return $result;
        }
	}
