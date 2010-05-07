<?php
	
	class SqlManager {
		
		protected $insert_id;
		
		function SqlManager($host, $user, $pass, $db) {
			session_start();
			mysql_connect($host, $user, $pass);
			mysql_select_db($db);
			mysql_query("SET NAMES 'utf8'");
		}

		/**
		 * Fun‹o para executar um SQL, retornando uma linha do banco de dados. Para receber mais de uma linha como resultado, 
		 * utilize o $return como null e faa o tratamento.
		 * 
		 * @param $fields String
		 * @param $table String
		 * @param $where String [optional]
		 * @param $order String [optional]
		 * @param $return String [optional]
		 * @param $complement String [optional]
		 * @return Array || Object || Resource
		 */
		protected function doSingleSelect($fields, $table, $where = null, $order = null, $return = null, $complement = null) {
			
			// Montando o SQL.
			$sql = "SELECT $fields FROM $table ";
			
			// WHERE
			if($where != null) {
				$sql .= "WHERE $where ";
			}
			
			// ORDER BY
			if($order != null) {
				$sql .= "ORDER BY $order";
			}
			
			$result = mysql_query($sql);
			
			switch($return) {
				case "array":
					return mysql_fetch_array($result, $complement);
					break;
				
				case "object":
					return mysql_fetch_object($result ,$complement);
					break;
					
				default:
					return $result;
					break;
			}
			
			
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
				$this->insert_id = mysql_insert_id();
				return true;
			} else { 
				$this->insert_id = "";
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
				$this->insert_id = mysql_insert_id();
				return true;
			} else {
				$this->insert_id = "";
				return mysql_error();
			}
			
		}
		
		//-----------------------------------------------
		//
		//	doDelete
		//
		//-----------------------------------------------
		protected function doDelete($where, $table) {
			
			$sql = "DELETE FROM $table WHERE $where";
			
			if(mysql_query($sql)) {
				return true;
			} else {
				return mysql_error();
			}
			
		}
	
	}
