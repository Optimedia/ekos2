<?php
// test.php

require_once('bootstrap.php');
//require_once('models/EkoUserTag.php');
echo "[" . Doctrine::getPath() . "]";
//Doctrine::generateModelsFromDb('models', array('doctrine'), array('generateTableClasses' => true));
$user = new EkoUser();
echo "\n[2]";
$user->password = 'changeme';
echo "\n[3]";
echo "\n". $user->password; // outputs md5 hash and not changeme
echo "\n[4]";
$list = Doctrine::getTable('EkoUser')->getActives();
var_dump($list);
echo "\n[5]";
