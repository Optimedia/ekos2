<?

require_once ('../includes/SqlManager.php');

require_once ('../vo/bookmark/vo/BookmarkVO.php');


class BookmarkService extends SqlManager{
			
		public function BookmarkService()
		  {
			parent::SqlManager("localhost", "root", "", "ekos");
		}
    
    //RETORNA BOOKMARK
    public function retrieveBookmark()
    {
		$bookmarkVO = new BookmarkVO();
		$bookmarkVOArray = array();
		
		$sql = "SELECT * FROM bkm_bookmark";
    $query = parent::doSelect($sql);

    while($bookmarkVO = mysql_fetch_object($query, "BookmarkVO")) {
				$bookmarkVOArray[] = $bookmarkVO;
			}
    return $bookmarkVOArray;
    }
    
		//INSERE OU ATUALIZA BOOKMARK
		public function saveBookmark(BookmarkVO $bookmarkVO) {
				if($bookmarkVO -> bookmark_id == 0) {
					$data = array(
									"user_id" => 11,
									"title"  => $bookmarkVO -> title, 
								  "description" => $bookmarkVO -> description,
								  "url" => $bookmarkVO -> url,
								  "tags" => $bookmarkVO -> tags,
								  "creation_date" => date("Y/m/d H:i:s")								  
								  );

					return parent::doInsert($data, "bkm_bookmark");
				} else {
					$bookmarkVO -> creation_date = date("Y/m/d H:i:s");
					$data = array(
									"user_id" => 11,
									"title"  => $bookmarkVO -> title, 
								  "description" => $bookmarkVO -> description,
								  "url" => $bookmarkVO -> url,
								  "tags" => $bookmarkVO -> tags,
								  "creation_date" => date("Y/m/d H:i:s"));
					
					return parent::doUpdate($data, "bookmark_id=".$bookmarkVO->bookmarkID,  "bkm_bookmark");
				}
		}
    
    //DELETA BOOKMARK
    public function deleteBookmark(BookmarkVO $bookmarkVO){
    						
			return parent::doDelete("bookmark_id=".$bookmarkVO->bookmarkID,"bkm_bookmark");
    	
    }

}
