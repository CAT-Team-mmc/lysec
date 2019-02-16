<?php
/**
 * Created by PhpStorm.
 * User: user
 * Date: 16-8-2
 */

use Phalcon\Events\Event;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Mvc\Dispatcher\Exception as DispatchException;

class ExceptionsPlugin
{
    public function beforeException(Event $event, Dispatcher $dispatcher, $exception)
    {
        // 处理404异常
        if ($exception instanceof DispatchException) {
//            echo $dispatcher->getControllerName();
//            echo $dispatcher->getActionName();
//            die();
            $dispatcher->forward(array(
                'controller' => 'index',
                'action'     => 'show404'
            ));
            return false;
        }

//        // 处理其他异常
//        $dispatcher->forward(array(
//            'controller' => 'index',
//            'action'     => 'show503'
//        ));

        return false;
    }
}