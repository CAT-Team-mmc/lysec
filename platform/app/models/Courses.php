<?php

class Courses extends \Phalcon\Mvc\Model
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
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $name;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $description;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $report;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=true)
     */
    public $category;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $url;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $image;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $create_at;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $state;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $config;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $analysis;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $is_web;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $afterclass;

    public function initialize()
    {
        $this->hasOne("category", "CourseCategory", "id");
        $this->hasMany("id", "CourseAccess", "course_id");
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'courses';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Courses[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Courses
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
