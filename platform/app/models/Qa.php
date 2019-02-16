<?php

class Qa extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Identity
     * @Column(type="string", length=20, nullable=false)
     */
    public $id;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=true)
     */
    public $meta_key;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $meta_value;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $type;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'qa';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Qa[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Qa
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
