<?php
	
	require_once('config.php');
	
	class SqlManager {
		
		private $_host = HOST;
		private $_user = USER;
		private $_pass = PASS;
		
		function SqlManager($_db) {
			session_start();
			mysql_connect($this -> _host, $this -> _user, $this -> _pass);
			mysql_select_db($_db);
		}
		
		//-----------------------------------------------
		//
		//	doSelect
		//
		//-----------------------------------------------
		protected function doSelect($sql) {
						
			$query = mysql_query($sql);
			
			if($query == false) {
				return mysql_error();
			} else {
				return $query;
			}
			
		}
		
		//-----------------------------------------------
		//
		//	doInsert
		//
		//-----------------------------------------------
		protected function doInsert($array, $table) {
			
			$fields = "(";
			$values = "VALUES (";
			
			$i = count($array);
			$j = 1;
			
			foreach ($array as $key => $value) {
				
				$fields .= $key;
				$values .= "'$value'";
				
				if($j < $i) {
					$fields .= ",";
					$values .= ",";
					$j ++;
				} else if($j == $i) {
					$fields .= ")";
					$values .= ")";
				}
				
			}
			
			$sql = "INSERT INTO ".$table." $fields $values";
			
			if(mysql_query($sql)) {
				return true;
			} else { 
				return mysql_error();
			}
			
		}
		
		//-----------------------------------------------
		//
		//	doUpdate
		//
		//-----------------------------------------------
		protected function doUpdate($array, $condition, $table) {
			
			$values = "";
			
			$i = count($array);
			$j = 1;
			
			foreach ($array as $key => $value) {
				$values .= "$key='$value'";
				
				if($j < $i) {
					$values .= ",";
					$j ++;
				}
			}
			
			$sql = "UPDATE $table SET $values WHERE $condition";
			
			if(mysql_query($sql)) {
				return true;
			} else {
				return mysql_error();
			}
			
		}
		
		//-----------------------------------------------
		//
		//	doDelete
		//
		//-----------------------------------------------
		protected function doDelete($where, $table) {
			
			$sql = "DELETE FROM $table $where";
			
			if(mysql_query($sql)) {
				return true;
			} else {
				return mysql_error();
			}
			
		}
	
	}

?>