<?php
require_once ('./vo/br/com/interludio/VOUser.php');

//conection info
define( "DATABASE_SERVER", "localhost");
define( "DATABASE_USERNAME", "root");
define( "DATABASE_PASSWORD", "optimedia");
define( "DATABASE_NAME", "teste_vo");

class MyService {

    public function getData() {
        //connect to the database.
        $mysql = mysql_connect(DATABASE_SERVER, DATABASE_USERNAME, DATABASE_PASSWORD);
        mysql_select_db(DATABASE_NAME);
        //retrieve all rows
        $query = "SELECT * FROM usuarios";
        $result = mysql_query($query);

        $ret = array();
        while ($row = mysql_fetch_object($result)) {
        	
            $tmp = new VOUser();
            
            $tmp -> id = $row -> id;
            $tmp -> nome = $row -> nome;
            $tmp -> login = $row -> login;
            
            $ret[] = $tmp;
        }
        mysql_free_result($result);
        return $tmp;
    }

	public function saveData($usuario) {
	    if ($usuario == NULL)
	        return NULL;
	    //connect to the database.
	    $mysql = mysql_connect(DATABASE_SERVER, DATABASE_USERNAME, DATABASE_PASSWORD);
	    mysql_select_db(DATABASE_NAME);
	    //save changes
	    $query = "UPDATE usuarios SET nome='".$usuario -> nome."'";
	    $result = mysql_query($query);
	    return NULL;
	}
}
?>