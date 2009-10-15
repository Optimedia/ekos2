<?

require_once ('../includes/SqlManager.php');

require_once ('../vo/forum/vo/UserVO.php');

class UserService extends SqlManager {

	public function UserService() {
		parent::SqlManager("localhost", "root", "optimedia", "forum");
	}

	public function getUserData($userID) {
		$sql = "SELECT * FROM idm_user WHERE userID=$userID";
		$query = parent::doSelect($sql);
		//$query = mysql_query($sql);
		
		$userVO = new UserVO();
		$userVO = mysql_fetch_object($query, "UserVO");
		
		//$teste = mysql_fetch_array($query);
		
		// $userVO -> id = $busca['ID_PROFILE'];
		// $userVO -> avatarLink = $busca['URL_AVATAR'];
		// $userVO -> numPosts = $busca['NU_POSTS'];
		// $userVO -> nome = $busca['NA_USER'];
		// $userVO -> sobrenome = $busca['NA_SURNAME'];
		// $userVO -> perfil = $busca['ID_ROLE'];
		// $userVO -> pais = $busca['NA_COUNTRY'];
		// $userVO -> estado = $busca['NA_STATE'];
		// $userVO -> cidade = $busca['NA_CITY'];
		// $userVO -> dataCadastro = $busca['DT_CREATION'];

		return $userVO;
		// $result = array();
		
		// while($busca = mysql_fetch_object array($query)) {
			// $userVO = new UserVO();
			
			// $userVO -> id = $busca['ID_PROFILE'];
			// $userVO -> avatarLink = $busca['URL_AVATAR'];
			// $userVO -> numPosts = $busca['NU_POSTS'];
			// $userVO -> nome = $busca['NA_USER'];
			// $userVO -> sobrenome = $busca['NA_SURNAME'];
			// $userVO -> perfil = $busca['ID_ROLE'];
			// $userVO -> pais = $busca['NA_COUNTRY'];
			// $userVO -> estado = $busca['NA_STATE'];
			// $userVO -> cidade = $busca['NA_CITY'];
			// $userVO -> dataCadastro = $busca['DT_CREATION'];
			
			// $result[] = $userVO;
		// }
		
		// return $result;
	}
	
	/*public function setItem($item, $tableName) {
		
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
		
	}*/
}