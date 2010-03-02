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
						                    "alltext" => "<script language=\"javascript\" src=\"/Interactive/includeAll.js\"></script><script language=\"javascript\" src=\"/Interactive/AC_OETags.js\"></script><script language=\"javascript\" src=\"/Interactive/history/history.js\"></script><script language=\"javascript\" src=\"/Interactive/testBrowser.js\"></script><embed height=\"512\" align=\"middle\" width=\"800\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.adobe.com/go/getflashplayer\" allowscriptaccess=\"sameDomain\" name=\"Interactive\" bgcolor=\"#869ca7\" quality=\"high\" id=\"Interactive\" src=\"/Interactive/Interactive.swf?_presentation=$presentationID&_idSlide=\"<?php echo 0 ?>\" /> <noscript> <object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" id=\"Interactive\" width=\"800\" height=\"512\" codebase=\"http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab\"> <param name=\"movie\" value=\"Interactive.swf\" /> <param name=\"quality\" value=\"high\" /> <param name=\"bgcolor\" value=\"#869ca7\" /> <param name=\"allowScriptAccess\" value=\"sameDomain\" /> <param name=\"flashVars\" value=\"_presentation=18&_idSlide=0\"/> <embed src=\"/Interactive/Interactive.swf\" quality=\"high\" bgcolor=\"#869ca7\" width=\"800\" height=\"512\" name=\"Interactive\" align=\"middle\" play=\"true\" loop=\"false\" quality=\"high\" allowScriptAccess=\"sameDomain\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.adobe.com/go/getflashplayer\"></embed> </object></noscript>",
						                    "popup" =>"",
						                    "options" =>"",
						                    "timemodified" =>"1248132589"
											);
	    
	        $result = parent::doInsert($fieldsAndValuesResource,"mdl_resource");
	        
	        $this-> instances = $this->insert_id;
	        
	        if( $result == true ) {
		        return $this->insertCourseModule();
	        }
			//return $this-> instancesResource;
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
            
            if( $result == true ){
            	$result = parent::doUpdate($fieldsAndValuesPresentation,$condition,"ekos2.ath_presentation");
            }
            if( $result == true ){
			    return $this-> insertContext();
            }
		    
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
		    
		    if( $result == true ) {
			    $result = parent::doUpdate( $fieldsAndValuesResource, $condition, "mdl_context" );
		    }
		    if( $result == true ) {
			    return $this->insertCourseSection();
		    }
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
			
		    return parent::doUpdate($fieldsAndValuesResource,$condition,"mdl_course_sections");
			
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
            
            return parent::doUpdate($fieldsAndValuesSection,$condition,"mdl_course_sections");

        }
	}
