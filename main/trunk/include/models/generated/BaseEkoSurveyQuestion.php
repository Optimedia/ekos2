<?php

/**
 * BaseEkoSurveyQuestion
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $survey_question_id
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 6401 2009-09-24 16:12:04Z guilhermeblanco $
 */
abstract class BaseEkoSurveyQuestion extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('eko_survey_question');
        $this->hasColumn('survey_question_id', 'integer', 8, array(
             'type' => 'integer',
             'unsigned' => 0,
             'primary' => true,
             'autoincrement' => false,
             'length' => '8',
             ));
    }

}