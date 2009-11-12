<?php
class User extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->hasColumn('account_id', 'int');//NULL;"PRI";"auto_increment"
        $this->hasColumn('email', 'string', 200);//UNI;NOT NULL
        $this->hasColumn('name', 'string', 128);//UNI;NOT NULL
        $this->hasColumn('status', 'string', 6);//NOT NULL
    }

    public function setUp()
    {
        $this->actAs('Timestampable');
    }
}





