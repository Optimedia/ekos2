<?php

/**
 * BaseEkoMembership
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $membership_id
 * @property integer $id_node
 * @property integer $group_id
 * @property integer $user_id
 * @property integer $status
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 6401 2009-09-24 16:12:04Z guilhermeblanco $
 */
abstract class BaseEkoMembership extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('eko_membership');
        $this->hasColumn('membership_id', 'integer', 8, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => true,
             'autoincrement' => true,
             'length' => '8',
             ));
        $this->hasColumn('id_node', 'integer', 8, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => false,
             'notnull' => true,
             'autoincrement' => false,
             'length' => '8',
             ));
        $this->hasColumn('group_id', 'integer', 8, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => false,
             'notnull' => true,
             'autoincrement' => false,
             'length' => '8',
             ));
        $this->hasColumn('user_id', 'integer', 8, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => false,
             'notnull' => true,
             'autoincrement' => false,
             'length' => '8',
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