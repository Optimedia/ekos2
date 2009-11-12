<?php
// bootstrap.php

require_once(dirname(__FILE__) . '/lib/vendor/doctrine/Doctrine.php');
spl_autoload_register(array('Doctrine', 'autoload'));
$manager = Doctrine_Manager::getInstance();

$manager->setAttribute(Doctrine::ATTR_QUOTE_IDENTIFIER, true);
$manager->setAttribute(Doctrine::ATTR_VALIDATE, Doctrine::VALIDATE_ALL);
$manager->setAttribute(Doctrine::ATTR_EXPORT, Doctrine::EXPORT_ALL);
$manager->setAttribute(Doctrine::ATTR_MODEL_LOADING, Doctrine::MODEL_LOADING_CONSERVATIVE);
$manager->setAttribute(Doctrine::ATTR_AUTO_ACCESSOR_OVERRIDE, true);
$manager->setAttribute(Doctrine::ATTR_AUTOLOAD_TABLE_CLASSES, true);

$dsn = 'mysql:dbname=ekos2;host=10.1.1.10';
$user = 'opti';
$password = 'opti';

//$dbh = new PDO($dsn, $user, $password);
$conn = Doctrine_Manager::connection("mysql://$user:$password@10.1.1.10/ekos2");

Doctrine::loadModels('models');

/*
$stmt = $conn->execute('SHOW TABLES');
$results = $stmt->fetchAll();
print_r($results);
*/