<?php
	
	/**
	 * Classe que reúne todos os dados do usuário no ekos.
	 * 
	 * 		UserVO
	 * 		ProfileVO
	 * 		AccountVO 
	 */
	class CompleteUserVO {
		
		// UserVO
		public $user_id;
		public $role_id;
		public $first_name;
		public $last_name;
		public $password;
		
		// ProfileVO
		public $profile_id;
		public $nickname;
		public $small_avatar;
		public $large_avatar;
		public $sex;
		public $birthday;
		
		// AccountVO
		public $account_id;
		public $email;
		public $name;
		public $status;
		
		// Details
		public addressArray;
		public educationArray;
		public languageArray;
		public professionArray;
		
		public $_explicitType = "br.com.optimedia.assets.vo.CompleteUserVO";
		
	}
	
?>
