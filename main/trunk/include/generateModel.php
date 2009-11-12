<?php
// generateModel.php
require_once('bootstrap.php');
Doctrine::generateModelsFromYaml('schema.yml', 'models', array('doctrine'), array('generateTableClasses' => true));