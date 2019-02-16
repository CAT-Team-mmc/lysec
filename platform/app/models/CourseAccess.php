<?php

class CourseAccess extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=10, nullable=false)
     */
    public $id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $user_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $course_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $state;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $create_at;

    public function initialize()
    {
        $this->belongsTo("user_id", "Users", "id");
        $this->belongsTo("course_id", "Courses", "id");
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'course_access';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CourseAccess[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CourseAccess
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
