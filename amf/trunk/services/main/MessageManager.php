<?php
	
	require_once '../includes/SqlManager.php';	
	require_once '../vo/br/com/optimedia/assets/vo/MessageVO.php';
	
	class MessageManager extends SqlManager {
		
		private $_table = "eko_message";
		
		public function MessageManager() {
			$host = "10.1.1.10";
			$user = "opti";
			$pass = "opti";
			$db = "ekos2";
			
			parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Fun��o para buscar todas mensagens recebidas pelo usu�rio
		 * 
		 * - Retorna: Array MessageVO
		 * .
		 * @param uint
		 */
		private function getAllReciveMessages() {
			$sql = "SELECT * FROM eko_message WHERE reciver_profile_id=".$_SESSION['account_id'];
			$result = parent::doSelect($sql);
			
			$message = new MessageVO();
			$arrayMessage = array();
			
			while($message = mysql_fetch_object($result)) {
				$arrayMessage[] = $message;
			}
			
			return $arrayMessage;
		}
		
		/**
		 * Fun��o para envio de mensagem para um usu�rio
		 * 
		 * - Retorna: Boolean
		 * .
		 * @param MessageVO
		 */
		public function sendPrivateMessage() {
			$message = new MessageVO();
			$message -> receiver_profile_id = 9;
			$message -> subject = 'fasd';
			$message -> text = 'asssss';
			
			$arrayMessage = array('sender_profile_id' 	=> $_SESSION['account_id'],
								  'receiver_profile_id' 	=> $message -> receiver_profile_id,
								  'sender_status' 		=> 1,
								  'receiver_status' 		=> 2,
								  'send_date' 			=> 'FIX ME',
								  'subject' 			=> $message -> subject,
								  'text' 				=> $message -> text);
								  
			return parent::doInsert($arrayMessage, $this -> _table);
			
		}
		
		/**
		 * Fun��o para deletar mensagem de um usu�rio
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