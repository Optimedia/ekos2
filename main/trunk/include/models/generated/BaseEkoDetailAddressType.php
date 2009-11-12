<?php

/**
 * BaseEkoDetailAddressType
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $detail_address_type_id
 * @property string $name
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 6401 2009-09-24 16:12:04Z guilhermeblanco $
 */
abstract class BaseEkoDetailAddressType extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('eko_detail_address_type');
        $this->hasColumn('detail_address_type_id', 'integer', 8, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => true,
             'autoincrement' => true,
             'length' => '8',
             ));
        $this->hasColumn('name', 'string', 50, array(
             'type' => 'string',
             'fixed' => 0,
             'primary' => false,
             'notnull' => true,
             'autoincrement' => false,
             'length' => '50',
             ));
    }

}