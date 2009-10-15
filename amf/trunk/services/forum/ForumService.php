<?

require_once ('../includes/SqlManager.php');

require_once ('../vo/forum/vo/CategoryVO.php');
require_once ('../vo/forum/vo/ForumVO.php');
require_once ('../vo/forum/vo/RoomVO.php');
require_once ('../vo/forum/vo/TopicVO.php');


class ForumService extends SqlManager{
		
	public function ForumService() {
		parent::SqlManager("localhost", "root", "optimedia", "forum");
	}
	
	public function saveCategory(CategoryVO $categoryVO) {
		if($categoryVO -> categoryID == 0) {
			$data = array("name"  => $categoryVO -> name, 
						  "description" => $categoryVO -> description);
				
			return parent::doInsert($data, "forum_category");
		}
		else {
			$data = array("name"  => $categoryVO -> name, 
						  "description" => $categoryVO -> description);
				
			return parent::doUpdate($data, "categoryID=".$categoryVO->categoryID,  "forum_category");
		}
	}
	
	public function retrieveCategories() {
		$categoryVO = new CategoryVO();
		$categoryVOArray = array();
		
		$sql = "SELECT * FROM forum_category ORDER BY 'categoryID' ASC";
		$query = parent::doSelect($sql);
		while($categoryVO = mysql_fetch_object($query, "CategoryVO")) {
			$forumVO = new ForumVO();
			$forumVOArray = array();
			
			$sql1 = "SELECT * FROM forum_forum f WHERE f.categoryID = {$categoryVO->categoryID} ORDER BY 'forumID' ASC";
			$query1 = parent::doSelect($sql1);
			while($forumVO = mysql_fetch_object($query1, "ForumVO")) {
				$forumVOArray[] = $forumVO;
			}
			$categoryVO -> forumVOArray = $forumVOArray;
			$categoryVOArray[] = $categoryVO;
		}
		return $categoryVOArray;
	}
	
	public function retrieveRooms(forumVO $forumVO) {
		$roomVO = new RoomVO();
		$roomVOArray = array();
	
		$sql = "SELECT * FROM forum_room f WHERE f.forumID = {$forumVO->forumID}";
		$query = parent::doSelect($sql);
		while($roomVO = mysql_fetch_object($query, "RoomVO")) {
			$roomVOArray[] = $roomVO;
		}
		return $roomVOArray;
	}
	
	public function retrieveTopics(RoomVO $roomVO) {
		$topicVO = new TopicVO();
		$topicVOArray = array();
	
		$sql = "SELECT * FROM forum_topic f WHERE f.roomID = {$roomVO->roomID}";
		$query = parent::doSelect($sql);
		while($roomVO = mysql_fetch_object($query, "TopicVO")) {
			$topicVOArray[] = $topicVO;
		}
		return $topicVOArray;
	}
	public function retrievePosts(TopicVO $topicVO) {
		$postVO = new PostVO();
		$postVOArray = array();
	
		$sql = "SELECT * FROM forum_post f WHERE f.topicID = {$topicVO->topicID}";
		$query = parent::doSelect($sql);
		while($roomVO = mysql_fetch_object($query, "PostVO")) {
			$postVOArray[] = $PostVO;
		}
		return $postVOArray;
	}
}