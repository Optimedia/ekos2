<?

require_once ('../includes/SqlManager.php');

require_once ('../vo/bookmark/vo/BookmarkVO.php');


class BookmarkService extends SqlManager{
		
	public function BookmarkService()
    {
		parent::SqlManager("localhost", "root", "", "bookmarkdb");
	}
	
	
    public function retrieveBookmark()
    {
		$bookmarkVO = new BookmarkVO();
		$bookmarkVOArray = array();
		
		$sql = "SELECT * FROM bkm_entry";
    $query = parent::doSelect($sql);

    while($bookmarkVO = mysql_fetch_object($query, "BookmarkVO")) {
				$bookmarkVOArray[] = $bookmarkVO;
			}
    return $bookmarkVOArray;
    }
    
 
      
	
		public function saveBookmark(BookmarkVO $bookmarkVO) {
			if($bookmarkVO -> bookmarkID == 0) {
				$data = array("title"  => $bookmarkVO -> title, 
							  "description" => $bookmarkVO -> description,
							  "url" => $bookmarkVO -> url,
							  "tags" => $bookmarkVO -> tags,
							  "lastchange" => date("Y/m/d H:i:s")
							  );
					
				return parent::doInsert($data, "bkm_entry");
			}
			else {
				$bookmarkVO -> lastchange = date("Y/m/d H:i:s");
				$data = array("title"  => $bookmarkVO -> title, 
							  "description" => $bookmarkVO -> description,
							  "url" => $bookmarkVO -> url,
							  "tags" => $bookmarkVO -> tags,
							  "lastchange" => date("Y/m/d H:i:s"));
							  
					
			return parent::doUpdate($data, "bookmarkID=".$bookmarkVO->bookmarkID,  "bkm_entry");
		}
	}
    public function deleteBookmark(BookmarkVO $bookmarkVO){
    						
			return parent::doDelete("bookmarkID=".$bookmarkVO->bookmarkID,"bkm_entry");
    	
    }

}
