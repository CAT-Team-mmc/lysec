<?php

class CourseCategory extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $id;

    /**
     *
     * @var string
     * @Column(type="string", length=30, nullable=false)
     */
    public $cate_name;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $parent_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $sort_order;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $code;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'course_category';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CourseCategory[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CourseCategory
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
