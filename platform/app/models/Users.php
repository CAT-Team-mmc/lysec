<?php

use Phalcon\Mvc\Model\Validator\Email as Email;

class Users extends \Phalcon\Mvc\Model
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
     * @Column(type="string", length=32, nullable=false)
     */
    public $username;

    /**
     *
     * @var string
     * @Column(type="string", length=40, nullable=false)
     */
    public $password;

    /**
     *
     * @var string
     * @Column(type="string", length=120, nullable=true)
     */
    public $name;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=false)
     */
    public $role;

    /**
     *
     * @var string
     * @Column(type="string", length=70, nullable=false)
     */
    public $email;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $created_at;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $active;

    /**
     *
     * @var string
     * @Column(type="string", length=11, nullable=true)
     */
    public $phone;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=true)
     */
    public $icon_url;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $login_last_ip;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $pay_flag;

    /**
     * Validations and business logic
     *
     * @return boolean
     */
    public function validation()
    {
//        $this->validate(
//            new Email(
//                array(
//                    'field'    => 'email',
//                    'required' => true,
//                )
//            )
//        );
//
//        if ($this->validationHasFailed() == true) {
//            return false;
//        }

        return true;
    }

    public function initialize()
    {
        $this->hasMany("id", "CourseAccess", "user_id");
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'users';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Users[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Users
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
