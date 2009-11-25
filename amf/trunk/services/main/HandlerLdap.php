<?php
	
	require "LdapIntegration.php";
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';

	class HandlerLdap extends HandlerBase {
		
		function insert(CompleteUserVO $completeUser) {
			
			$ldap = new LdapIntegration();
			$ldap -> bindAsAdmin();
			
			//echo "<pre>";var_dump($dataIdm);echo "</pre>";exit;
			
			$result = $ldap->createUser($completeUser -> account_id, 
										$completeUser -> name, 
										$completeUser -> password, 
										$completeUser -> name, 
										$completeUser -> name, 
										$completeUser -> email);
										 
			return ($ldap->lastError() == 'Success') ? NULL : $ldap->lastError();
		}
		
		function update(&$dataIdm) {
			return "HandlerLdap->update";
		}
		
		function select(&$dataIdm) {
			return "HandlerLdap->select";
		}
	}
