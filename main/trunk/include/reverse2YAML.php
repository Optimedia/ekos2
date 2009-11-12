<?php
// generateYAML.php

require_once('bootstrap.php');
//require_once('models/EkoUserTag.php');
Doctrine::generateYamlFromModels('schema.yml', 'models');