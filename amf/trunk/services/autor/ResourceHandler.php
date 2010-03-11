<?php
    require_once '../includes/SqlManager.php';

	class ResourceHandler extends SqlManager {
        
		protected $db_name = sinasemdl;
        protected $course = 3;
        protected $instances;
        protected $instancesModule;
        protected $sectionID;
        protected $presentationID;
        
		public function ResourceHandler() {
			$host = "74.54.27.146:3309";
			$user = "root";
			$pass = "0pt1m3d14SQL";
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
						                    "alltext" => "<script language=\"javascript\"> var PRESENTATIONID= $presentationID</script><script language=\"javascript\" src=\"/sinase.moodle/interactive/AC_OETags.js\"></script><script language=\"javascript\" src=\"/sinase.moodle/interactive/history/history.js\"></script><script language=\"javascript\" src=\"/sinase.moodle/interactive/testBrowser.js\"></script> ",
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
		    $fieldsAndValuesResource= array("course" => $this->course,
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
		    
		    return $result;
		}
		
		function insertContext() {
		    $fieldsAndValuesResource= array("contextlevel" => "70",
						                    "instanceid" => $this->instances,
						                    "path" => "/1/3/46/",
						                    "depth" => "4"
											);
		    
		    $result = parent::doInsert($fieldsAndValuesResource,"mdl_context");
		    
		    $this-> instances = $this -> insert_id;
		    
		    $fieldsAndValuesResource= array( "path" => "/1/3/46/$this->instances" );
		    
		    $condition = "id=$this->instances";
		    
		    $result = parent::doUpdate( $fieldsAndValuesResource, $condition, "mdl_context" );
		    
		    $this->insertCourseSection();
		    
		    return $result;
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
			
			return $result;
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
