<?php

/**
 * BaseEkoUserVoting
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $user_voting_id
 * @property string $vote
 * @property date $date
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 6401 2009-09-24 16:12:04Z guilhermeblanco $
 */
abstract class BaseEkoUserVoting extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('eko_user_voting');
        $this->hasColumn('user_voting_id', 'integer', 8, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => true,
             'autoincrement' => false,
             'length' => '8',
             ));
        $this->hasColumn('vote', 'string', 10, array(
             'type' => 'string',
             'fixed' => 1,
             'primary' => false,
             'notnull' => false,
             'autoincrement' => false,
             'length' => '10',
             ));
        $this->hasColumn('date', 'date', 25, array(
             'type' => 'date',
             'primary' => false,
             'notnull' => false,
             'autoincrement' => false,
             'length' => '25',
             ));
    }

}