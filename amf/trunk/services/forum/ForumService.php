<?

require_once ('../includes/SqlManager.php');

require_once ('../vo/forum/vo/UserVO.php');
require_once ('../vo/forum/vo/CategoryVO.php');
//require_once ('../vo/forum/vo/RoomVO.php');

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
		$sql = "SELECT * FROM forum_category ORDER BY 'categoryID' ASC";
		$query = parent::doSelect($sql);
		$categoryVO = new CategoryVO();
		$arrayCategory = array();
		
		while($categoryVO = mysql_fetch_object($query, "CategoryVO")) {
			$arrayCategory[] = $categoryVO;
		}
		
		return $arrayCategory;
	}
	/*
	public function getDados($nomeTabela) {
		
		$sql = "SELECT * FROM $nomeTabela ORDER BY `ID_MODULO` ASC";
		$query = mysql_query($sql);
		
		array($arrayDados);
		
		while($busca = mysql_fetch_array($query)) {
			$arrayDados[] = $busca;
		}
		
		return $arrayDados;
	}
	
	public function setItem($item, $tableName) {
		
		// insert = insert into tabela (nome, endereco) VALUES('tagua', 'felipe')
		// update = update tabela set nome='felipe', endereco='tagua' WHERE id=5
		// delete = delete FROM tabela WHERE id=5
		
		switch($tableName) {
			
			case "ida_modulo":
				if ($item['id'] == "" or $item['id'] == null or $item['id'] == 0) {
					$sql = "insert INTO $tableName (NO_MODULO, NO_TABELA) VALUES('".$item['nomeModulo']."', '".$item['nomeTabela']."')";
				}
				else {
					$sql = "UPDATE $tableName SET NO_MODULO='".$item['nomeModulo']."', NO_TABELA='".$item['nomeTabela']."' WHERE ID_MODULO=".$item['id'];
				}
				break;
			default:
				return "Falhou";
				break;
		}
		$query = mysql_query($sql);
		return "OK";
	}
	
	public function deleteItem($tableName, $itemID) {
		switch($tableName) {
			
			case "ida_modulo":
				$sql = "delete FROM $tableName WHERE ID_MODULO=$itemID";
				$query = mysql_query($sql);
				return "OK";
				break;
			default:
				return "Falhou";
				break;
		}
		
	}
	*/
}