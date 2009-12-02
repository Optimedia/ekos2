<?php
	
	require_once '../includes/SqlManager.php';	
	require_once '../vo/br/com/optimedia/assets/vo/MessageVO.php';
	
	class MessageManager {
		
		private $_table = "eko_message";
		
		public function MessageManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Funчуo para buscar todas mensagens recebidas pelo usuсrio
		 * 
		 * - Retorna: Array MessageVO
		 * .
		 * @param uint
		 */
		private function getAllReciveMessages($user_id) {
			$sql = "SELECT * FROM eko_message WHERE reciver_profile_id=$user_id";
			$result = parent::doSelect($sql);
			
			$message = new MessageVO();
			$arrayMessage = array();
			
			while($message = mysql_fetch_object($result)) {
				$arrayMessage[] = $message;
			}
			
			return $arrayMessage;
		}
		
		/**
		 * Funчуo para envio de mensagem para um usuсrio
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param MessageVO
		 */
		public function sendPrivateMessage(MessageVO $message) {
			$arrayMessage = array('sender_profile_id' 	=> $message -> sender_profile_id,
								  'reciver_profile_id' 	=> $message -> reciver_profile_id,
								  'sender_status' 		=> $message -> sender_status,
								  'reciver_status' 		=> $message -> reciver_status,
								  'send_date' 			=> $message -> send_date,
								  'subject' 			=> $message -> subject,
								  'text' 				=> $message -> text);
								  
			parent::doInsert($arrayMessage, $this -> _table);
			
		}
		
		/**
		 * Funчуo para deletar mensagem de um usuсrio
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param uint
		 */
		public function deleteMessage($message_id) {
			$where = "message_id=$message_id";
			
			parent::doDelete($where, $this -> _table);
		}
		
	}
	
?>