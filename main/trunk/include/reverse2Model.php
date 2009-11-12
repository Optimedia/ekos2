<?php
// generateModel.php
require_once('bootstrap.php');
Doctrine::generateModelsFromDb('models', array('doctrine'), array('generateTableClasses' => true));