<?php

/**
 * BaseEkoDetailEducation
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $detail_education_id
 * @property integer $profile_id
 * @property integer $detail_education_level_id
 * @property string $institution
 * @property integer $year
 * @property integer $status
 * @property string $course
 * @property string $title
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 6401 2009-09-24 16:12:04Z guilhermeblanco $
 */
abstract class BaseEkoDetailEducation extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('eko_detail_education');
        $this->hasColumn('detail_education_id', 'integer', 8, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => true,
             'autoincrement' => true,
             'length' => '8',
             ));
        $this->hasColumn('profile_id', 'integer', 8, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => false,
             'notnull' => false,
             'autoincrement' => false,
             'length' => '8',
             ));
        $this->hasColumn('detail_education_level_id', 'integer', 8, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => false,
             'notnull' => false,
             'autoincrement' => false,
             'length' => '8',
             ));
        $this->hasColumn('institution', 'string', 128, array(
             'type' => 'string',
             'fixed' => 0,
             'primary' => false,
             'notnull' => false,
             'autoincrement' => false,
             'length' => '128',
             ));
        $this->hasColumn('year', 'integer', 2, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => false,
             'notnull' => false,
             'autoincrement' => false,
             'length' => '2',
             ));
        $this->hasColumn('status', 'integer', 2, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => false,
             'notnull' => false,
             'autoincrement' => false,
             'length' => '2',
             ));
        $this->hasColumn('course', 'string', 128, array(
             'type' => 'string',
             'fixed' => 0,
             'primary' => false,
             'notnull' => false,
             'autoincrement' => false,
             'length' => '128',
             ));
        $this->hasColumn('title', 'string', 128, array(
             'type' => 'string',
             'fixed' => 0,
             'primary' => false,
             'notnull' => false,
             'autoincrement' => false,
             'length' => '128',
             ));
    }

}