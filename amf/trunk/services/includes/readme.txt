 - config.php

Configure este arquivo com os dados de acesso do banco;


 - SqlManager.php

Classe que contem m�todos do sql como: SELECT, INSERT, UPDATE e DELETE.

Importe esta classe e d� extends, no m�todo construtor chame o construtor do SqlManager e passe como valores o dados de acesso ao Banco de dados.

Ex.:
<?php
require_once '../includes/SqlManager.php';

class UsuarioManager extends SqlManager {
	
	public $_db = "ekos";

	public function UsuarioManager() {
		parent::SqlManager($this -> _db);
	}

}
?>

