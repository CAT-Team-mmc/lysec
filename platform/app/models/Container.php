<?php

class Container extends \Phalcon\Mvc\Model
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
     * @Column(type="integer", length=11, nullable=false)
     */
    public $course_id;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $image;

    /**
     *
     * @var string
     * @Column(type="string", length=25, nullable=true)
     */
    public $port;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $status;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $create_at;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=true)
     */
    public $cmd;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=true)
     */
    public $container_id;

    /**
     *
     * @var string
     * @Column(type="string", length=32, nullable=true)
     */
    public $domain;

    public function initialize()
    {
        $this->belongsTo('course_id', 'Courses', 'id');
        $this->belongsTo('user_id', 'Users', 'id');
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'container';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Container[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Container
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
