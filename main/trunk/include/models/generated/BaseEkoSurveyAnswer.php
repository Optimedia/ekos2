<?php

/**
 * BaseEkoSurveyAnswer
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $survey_alternative_id
 * @property integer $user_id
 * @property string $comment
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 6401 2009-09-24 16:12:04Z guilhermeblanco $
 */
abstract class BaseEkoSurveyAnswer extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('eko_survey_answer');
        $this->hasColumn('survey_alternative_id', 'integer', 8, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => true,
             'autoincrement' => false,
             'length' => '8',
             ));
        $this->hasColumn('user_id', 'integer', 8, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => true,
             'autoincrement' => false,
             'length' => '8',
             ));
        $this->hasColumn('comment', 'string', 10, array(
             'type' => 'string',
             'fixed' => 1,
             'primary' => false,
             'notnull' => false,
             'autoincrement' => false,
             'length' => '10',
             ));
    }

}