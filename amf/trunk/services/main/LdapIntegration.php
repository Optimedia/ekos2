<?php
class LdapIntegration {
	
	private $ldap_port = 389;
	
	private $ldap_host = "174.133.101.18";
	private $ldap_base = "DC=ibrasil,DC=net";
	private $ldap_admin_cn = "CN=admin, DC=ibrasil,DC=net";
  	private $ldap_base_users = "ou=users2,DC=ibrasil,DC=net";
	private $ldap_admin_pass = "cyd0n14789";
	private $ldap_conn;
	private $ldap_bind;
	
	function LdapIntegration() {
		if ($_SERVER["SERVER_ADDR"] == "10.1.1.10") {
			$this->ldap_host       		= "10.1.1.10";
			$this->ldap_base       		= "dc=10,dc=1,dc=1,dc=12";
			$this->ldap_14base_users	= "ou=users2,dc=10,dc=1,dc=1,dc=12";
			$this->ldap_admin_cn   		= "cn=admin, dc=10,dc=1,dc=1,dc=12";
			$this->ldap_admin_pass 		= "cyd0n14789";
		}
	}
	
	function getUID($username) {
		return "UID=$username, " . $this->ldap_base_users;
	}
	
	function connect() {
		$this->ldap_conn = ldap_connect ( $this->ldap_host, $this->ldap_port ) or die("");
		if (! $this->ldap_conn) return 1;
		ldap_set_option ( $this->ldap_conn, LDAP_OPT_PROTOCOL_VERSION, 3 );
	}
	
	function bind($cn, $password) {
		$this->connect ();
		try {
			$this->ldap_bind = ldap_bind($this->ldap_conn, $cn, $password);
    	return $this->ldap_bind;
		} catch (Exception $e) {
			if ( stripos($e->getMessage(), 'Invalid credentials') > 0) {
				return 'Não existe um usuário com esta senha.';
			} else {
				return $e->getMessage();
			}
		}
	}
	
	function bindAsAdmin() {
		return $this->bind($this->ldap_admin_cn, $this->ldap_admin_pass);
	}
	
	function bindAsUser($username, $password) {
		return $this->bind($this->getUID($username), $password);
	}
	
	function close() {
		ldap_close($this->ldap_conn);
	}
	
	function createUser($uidNumber, $login, $userPassword, $firstName, $last_name, $email) {
        $baseUsers = $this->ldap_base_users;
        $result = array();
        
        $dn = "uid=$login,$baseUsers";
        $fullname = "$firstName $last_name";
        $accountId = $uidNumber;
        
        $arr = array();
        //$arr["objectclass"]=array("person","organizationalPerson","top","inetOrgPerson","posixAccount");
        $arr["objectclass"]=array("person","organizationalPerson","top","inetOrgPerson","posixAccount");
        $arr["cn"] = $fullname;
        $arr["sn"] = $last_name;
        $arr["givenName"] = $firstName;
        $arr["mail"] = $email;
        $arr["homeDirectory"] = "/home/users/$login";
        $arr["uid"] = $login;
        $arr["uidNumber"] = $accountId;
        $arr["gidNumber"] = "9";
        //$arr["userPassword"] = '{MD5}' . base64_encode(md5($userPassword));
        $arr["userPassword"] = '{md5}' . base64_encode(pack('H*',md5($userPassword)));
        //echo "<pre>";var_dump($dn);var_dump($arr);echo "</pre>";exit;
        if (ldap_add($this->ldap_conn,$dn,$arr)) {
            $result["successMessage"] = "Account created successfully";
        } else { 
        	$result["errorMessage"] = "Account creation failed";
        };
        $result["accountId"] = $accountId;

        return $result;
	}
	
	function lastError() {
	    return ldap_error($this->ldap_conn);
	}
	
}