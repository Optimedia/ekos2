<?php

/**
 * BaseEkoAccount
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $account_id
 * @property string $email
 * @property string $name
 * @property integer $status
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 6401 2009-09-24 16:12:04Z guilhermeblanco $
 */
abstract class BaseEkoAccount extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('eko_account');
        $this->hasColumn('account_id', 'integer', 8, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => true,
             'autoincrement' => true,
             'length' => '8',
             ));
        $this->hasColumn('email', 'string', 200, array(
             'type' => 'string',
             'fixed' => 0,
             'primary' => false,
             'notnull' => true,
             'autoincrement' => false,
             'length' => '200',
             ));
        $this->hasColumn('name', 'string', 128, array(
             'type' => 'string',
             'fixed' => 0,
             'primary' => false,
             'notnull' => true,
             'autoincrement' => false,
             'length' => '128',
             ));
        $this->hasColumn('status', 'integer', 2, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => false,
             'notnull' => true,
             'autoincrement' => false,
             'length' => '2',
             ));
    }

}