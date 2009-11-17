<?php

  	require_once './LdapIntegration.php';
	require_once '../includes/SqlManager.php';
	require_once '../vo/br/com/optimedia/assets/vo/CompleteUserVO.php';
	
	/**
	* Função de Login do LDAP.
	*/
	class SsoConnect extends SqlManager {
		
		private $ldap;
		
		public function SsoConnect() {
			//session_id($_REQUEST[session_name()]);
			session_start();
		  $this->ldap = new LdapIntegration();
		  
		  $host = "10.1.1.10";
		  $user = "opti";
		  $pass = "opti";
		  $db = "ekos2";
		  
		  parent::SqlManager($host, $user, $pass, $db);
		}
		
		/**
		 * Função que faz o Login no LDAP, criando a sessão para o sso.
		 * 
		 * @return CompleteUserVO 
		 */		
		public function doLogin($login, $pass) {
			// Fazendo o login no LDAP
			$result = $this->ldap->bindAsUser($login, $pass);
			$result = gettype($result) == boolean ? $result : false;
			
			if ($result) {
								
				// Verificar se o usuário está ativo
				$sql = "SELECT a.* ,b.*, c.* FROM eko_account a, eko_user b, eko_profile c WHERE b.user_id=a.account_id AND c.profile_id=a.account_id";
				$query = parent::doSelect($sql);
				
				$completeUser = new CompleteUserVO();
				
				$completeUser = mysql_fetch_object($query, "CompleteUserVO");
				
				switch ($completeUser -> status) {
					
					// Temporario
					case 1:
						return 2;
						break;
					
					// Ativo
					case 2:
						return $completeUser;
						break;
					
					// Desativado					
					case 3:
						return 4;
						break;
					
					// Bloqueado
					case 4:
						return 5;
						break;
					
					// Apagado
					case 5:
						return 6;
						break;
				}
				
			} else {
				return 1; // Erro no login;
			}
		}
		
		public function getSession() {
			if(isset($_SESSION['login'])) {
				return 1; // Está logado, puxa o login
			} else if($_SESSION['next_url'] != "") {
				return $_SESSION['next_url']; // Redirecionar para outra pagina
			} else {
				return 3; // Faça o login, normalmente.
			}
			
		}
		
		public function getLogin() {
			//return $_SERVER["HTTP_COOKIE"];
			return $_SESSION['login'];
		}
		
		public function getUrl() {			
				
			if($_SESSION['next_url'] != "") {				
				return $_SESSION['next_url'];			
			} else {
				return null;
			}
		}		
				
		public function getCookie() {			
			if (isset($_SESSION['idm_user'])) {			    
				return $_SESSION['login'];			
			} else {				
				return null;			
			}		
		}		
		
		public function doLogout() {
			
			session_unset();
			session_destroy();
			return true;
			
		}
		
		public function createNextUrl($url) {
			$_SESSION['next_url'] = $url;
		}
		
		public function testeTodos() {			
			$result = array();
			$result[] = 'robson'              . ': ' . $this->ldap->bindAsUser('robson'               , 'robson'		); 
			$result[] = 'bernardo'            . ': ' . $this->ldap->bindAsUser('bernardo'             , '12345'     ); 
			$result[] = 'ruben.bauer'         . ': ' . $this->ldap->bindAsUser('ruben.bauer'          , '34122476'  ); 
			$result[] = 'robinho'             . ': ' . $this->ldap->bindAsUser('robinho'              , 'robq1w2e3' ); 
			$result[] = 'wmatematicasuperior' . ': ' . $this->ldap->bindAsUser('wmatematicasuperior'  , '36013291'  ); 
			$result[] = 'adenisio.souza'      . ': ' . $this->ldap->bindAsUser('adenisio.souza'       , '12345'     ); 
			$result[] = 'vlima'               . ': ' . $this->ldap->bindAsUser('vlima'                , '21211602'  ); 
			$result[] = 'anaclaudiaeducfiscal'. ': ' . $this->ldap->bindAsUser('anaclaudiaeducfiscal' , '12345'     ); 
			$result[] = 'valves'              . ': ' . $this->ldap->bindAsUser('valves'               , '33558388'  ); 
			$result[] = 'analum_martins'      . ': ' . $this->ldap->bindAsUser('analum_martins'       , '12345'     ); 
			$result[] = 'carlos.nacif'        . ': ' . $this->ldap->bindAsUser('carlos.nacif'         , '12345'     ); 
			$result[] = 'claudemir.frigo'     . ': ' . $this->ldap->bindAsUser('claudemir.frigo'      , '12345'     ); 
			$result[] = 'sabrina.dias'        . ': ' . $this->ldap->bindAsUser('sabrina.dias'         , '34126520'  ); 
			$result[] = 'tutoria.cleiton'     . ': ' . $this->ldap->bindAsUser('tutoria.cleiton'      , '12345'     ); 
			$result[] = 'rose.pacheco'        . ': ' . $this->ldap->bindAsUser('rose.pacheco'         , '34126196'  ); 
			$result[] = 'crisweyand'          . ': ' . $this->ldap->bindAsUser('crisweyand'           , '12345'     ); 
			$result[] = 'fisc_rendas'         . ': ' . $this->ldap->bindAsUser('fisc_rendas'          , '38664497'  ); 
			$result[] = 'dheliocosta'         . ': ' . $this->ldap->bindAsUser('dheliocosta'          , '12345'     ); 
			$result[] = 'ritadejesusoliveira' . ': ' . $this->ldap->bindAsUser('ritadejesusoliveira'  , '34124548'  ); 
			$result[] = 'edi_bio'             . ': ' . $this->ldap->bindAsUser('edi_bio'              , '12345'     ); 
			$result[] = 'rejane'              . ': ' . $this->ldap->bindAsUser('rejane'               , '12345'     ); 
			$result[] = 'ejorgerr'            . ': ' . $this->ldap->bindAsUser('ejorgerr'             , '12345'     ); 
			$result[] = 'albertogemaque'      . ': ' . $this->ldap->bindAsUser('albertogemaque'       , '12345'     ); 
			$result[] = 'li_leoa'             . ': ' . $this->ldap->bindAsUser('li_leoa'              , '12345'     ); 
			$result[] = 'patricia.mollo'      . ': ' . $this->ldap->bindAsUser('patricia.mollo'       , '34126260'  ); 
			$result[] = 'emanoel'             . ': ' . $this->ldap->bindAsUser('emanoel'              , '12345'     ); 
			$result[] = 'eva.torreias'        . ': ' . $this->ldap->bindAsUser('eva.torreias'         , '12345'     ); 
			$result[] = 'mercia'              . ': ' . $this->ldap->bindAsUser('mercia'               , '34126036'  ); 
			$result[] = 'gmfoss'              . ': ' . $this->ldap->bindAsUser('gmfoss'               , '12345'     ); 
			$result[] = 'zilda'               . ': ' . $this->ldap->bindAsUser('zilda'                , '33213551'  ); 
			$result[] = 'gisele'              . ': ' . $this->ldap->bindAsUser('gisele'               , '12345'     ); 
			$result[] = 'bezerraval'          . ': ' . $this->ldap->bindAsUser('bezerraval'           , '12345'     ); 
			$result[] = 'glauce.goncalves'    . ': ' . $this->ldap->bindAsUser('glauce.goncalves'     , '12345'     ); 
			$result[] = 'hozana'              . ': ' . $this->ldap->bindAsUser('hozana'               , '12345'     ); 
			$result[] = 'juracicamara'        . ': ' . $this->ldap->bindAsUser('juracicamara'         , '32169600'  ); 
			$result[] = 'isabella.machado'    . ': ' . $this->ldap->bindAsUser('isabella.machado'     , '12345'     ); 
			$result[] = 'mauxi321'            . ': ' . $this->ldap->bindAsUser('mauxi321'             , '99641803'  ); 
			$result[] = 'margareteiaraf'      . ': ' . $this->ldap->bindAsUser('margareteiaraf'       , '12345'     ); 
			$result[] = 'mamachado'           . ': ' . $this->ldap->bindAsUser('mamachado'            , '33803866'  ); 
			$result[] = 'marciarabelo'        . ': ' . $this->ldap->bindAsUser('marciarabelo'         , '92214495'  ); 
			$result[] = 'lidiaesaf'           . ': ' . $this->ldap->bindAsUser('lidiaesaf'            , '32016553'  ); 
			$result[] = 'lia.kusano'          . ': ' . $this->ldap->bindAsUser('lia.kusano'           , '34126164'  ); 
			$result[] = 'mvascamargo'         . ': ' . $this->ldap->bindAsUser('mvascamargo'          , '12345'     ); 
			$result[] = 'rfsantos'            . ': ' . $this->ldap->bindAsUser('rfsantos'             , '12345'     ); 
			$result[] = 'ciceromelo.educ'     . ': ' . $this->ldap->bindAsUser('ciceromelo.educ'      , '12345'     ); 
			$result[] = 'vinicius'            . ': ' . $this->ldap->bindAsUser('vinicius'             , '1234'      ); 
			$result[] = 'sergio'              . ': ' . $this->ldap->bindAsUser('sergio'               , '123654'    ); 
			$result[] = 'igorsm88'            . ': ' . $this->ldap->bindAsUser('igorsm88'             , 'cyd0n14'   ); 
			$result[] = 'kelsoncm'            . ': ' . $this->ldap->bindAsUser('kelsoncm'             , 'kelsoncm'  ); 
			$result[] = '28302346691'         . ': ' . $this->ldap->bindAsUser('28302346691'          , '105661'    ); 
			$result[] = 'elcimar'             . ': ' . $this->ldap->bindAsUser('elcimar'              , '12345'     ); 
			$result[] = 'eugenio.goncalves'   . ': ' . $this->ldap->bindAsUser('eugenio.goncalves'    , '12345'     ); 
			$result[] = 'jose.mascarenhas'    . ': ' . $this->ldap->bindAsUser('jose.mascarenhas'     , '12345'     ); 
			$result[] = 'reginaldo.araujo'    . ': ' . $this->ldap->bindAsUser('reginaldo.araujo'     , '12345'     ); 
			$result[] = 'marcus'              . ': ' . $this->ldap->bindAsUser('marcus'               , 'chera6666' ); 
			$result[] = 'joao.dias.neto'      . ': ' . $this->ldap->bindAsUser('joao.dias.neto'       , '1234'      ); 
			$result[] = 'pponte'              . ': ' . $this->ldap->bindAsUser('pponte'               , 'zaq'       ); 
			$result[] = 'dirce maria'         . ': ' . $this->ldap->bindAsUser('dirce maria'          , '91043017'  ); 
			$result[] = 'teste1430'           . ': ' . $this->ldap->bindAsUser('teste1430'            , '123456'    ); 
			$result[] = 'felipe'              . ': ' . $this->ldap->bindAsUser('felipe'               , '123456'    ); 
			$result[] = 'ivanstori'          	. ': ' . $this->ldap->bindAsUser('ivanstori'          	, 'naosei'    ); 
			
			$errors = array();
			foreach ( $result as $value ) {
				if (stripos($value, ': 1') == 0) {
					$errors[] = $value;
				}
			}
			return $errors;
		}
		
		public function validate() {
			return isset($_SESSION['user_logged']) && $_SESSION['user_logged'] != NULL;
		}		
		
		public function getUserInfo(){
		
			$login = $this->getLogin();
			$justthese = array("cn", "givenName", "uidNumber", "User Name", "mail");
			$dn = "ou=users,dc=10,dc=1,dc=1,dc=12";
			$filter="(|(uid=$login))";
			$ldaprdn = "CN=admin, DC=10,DC=1,DC=1,DC=12"; // ldap rdn or dn
			$ldappass = "cyd0n14789";
			
			$ldapconn = ldap_connect ( "10.1.1.10", 389 ) or die("Não foi conectado");
			ldap_set_option ( $ldapconn, LDAP_OPT_PROTOCOL_VERSION, 3 );
			$ldapbind = ldap_bind ( $ldapconn, $ldaprdn, $ldappass ) or die("Não foi BIND");
			$sr=ldap_search($ldapconn, $dn, $filter, $justthese);
			$info = ldap_get_entries($ldapconn, $sr);
			$result = array();
			if ($info["count"]>0) {
				$result[givenname] = $info[0]["givenname"][0]; 
				$result[uidnumber] = $info[0]["uidnumber"][0]; 
				$result[mail] = $info[0]["mail"][0]; 
				return $result;
			} else {
				die("Não encontrado o usuário");
			}
		}
		
	}
	
//require_once 'HandlerSql.php';