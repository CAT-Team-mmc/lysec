<?php

use Phalcon\Mvc\Controller;
use Phalcon\Translate\Adapter\NativeArray;

class ControllerBase extends Controller
{
    public function initialize()
    {
        $this->view->username = $this->session->get('auth')['username'];
        $this->view->t    = $this->getTranslation();
    }

    protected function getTranslation()
    {
        // Ask browser what is the best language
        $language = $this->request->getBestLanguage();

        // Check if we have a translation file for that lang
        // TODO 处理英文
        if (file_exists(APP_PATH . "/app/messages/" . $language . ".php")) {
            require_once APP_PATH. '/app/messages/'. $language . ".php";
        } else {
            require_once APP_PATH. '/app/messages/zh-CN.php';
            // Fallback to some default
//            require "../messages/en.php";
        }

        // Return a translation object
        return new NativeArray(
            array(
                "content" => $messages
            )
        );
    }

}
