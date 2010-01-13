<?php
	
	/**
	 * MessageVO
	 * 
	 * message_id			:uint
	 * sender_profile_id	:uint;
	 * reciver_profile_id	:uint;
	 * sender_status		:int;
	 * reciver_status		:int;
	 * send_date			:string;
	 * subject				:string;
	 * text					:string;
	 * 
	 * .
	 */
	class MessageVO {
		
		public $message_id;
		public $sender_profile_id;
		public $receiver_profile_id;
		public $sender_status;
		public $receiver_status;
		public $send_date;
		public $subject;
		public $text;
		
		public $_explicitType="br.com.optimedia.assets.vo.MessageVO";
		
	}

?>
