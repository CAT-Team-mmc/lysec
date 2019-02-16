<?php

use Docker\Docker;
use Docker\DockerClient;
use LinkORB\Component\Etcd\Client;
use Phalcon\Logger;
use Phalcon\Logger\Adapter\Firephp as Firephp;
use Phalcon\Mvc\View;

class LoginController extends ControllerBase
{

    public function indexAction()
    {
        $this->tag->setTitle("Login");
    }

    /**
     * 验证码验证
     */
    public function captchaAction()
    {
        $GtSdk = new GeetestLib($this->config->application->CAPTCHA_ID, $this->config->application->CAPTCHA_PRIVATE_KEY);
        $user_id = "test";
        $status = $GtSdk->pre_process($user_id);
        $this->session->set('gtserver', $status);
        $this->session->set('user_id', $user_id);
        $this->view->disableLevel(View::LEVEL_MAIN_LAYOUT);
        echo $GtSdk->get_response_str();
    }

    /**
     * 登陆操作
     */
    public function startAction()
    {
        if ($this->request->isPost()) {
            $email = $this->request->getPost('email');
            $password = $this->request->getPost('password');

            $flag = false;

            $GtSdk = new GeetestLib($this->config->application->CAPTCHA_ID, $this->config->application->CAPTCHA_PRIVATE_KEY);
            $user_id = $this->session->get('user_id');
            $this->view->disableLevel(View::LEVEL_MAIN_LAYOUT);
            if ($this->session->get('gtserver') == 1) {
                $result = $GtSdk->success_validate($_POST['geetest_challenge'], $_POST['geetest_validate'], $_POST['geetest_seccode'], $user_id);
                if ($result) {
                    $flag = true;
                }
            } else {
                if ($GtSdk->fail_validate($_POST['geetest_challenge'], $_POST['geetest_validate'], $_POST['geetest_seccode'])) {
                    $flag = true;
                }
            }

            if ($flag) {
                $user = Users::findFirst(array(
                    "(email = :email: OR phone = :email:)",
                    'bind' => array('email' => $email)
                ));

                $data = array();
                $data['auth'] = 1;

                if (($this->security->checkHash($password, $user->password)) && ($user->active == 1)) {
                    $this->_registerSession($user);
                    $user->login_last_ip = IPUtils::get_client_ip();
                    $user->save();
                    $data['status'] = 1;
                    if ($user->role === "admin") {
                        $data['url'] = 'admin/index';
                    } else {
                        $data['url'] = 'index/courses';
                    }
                    echo json_encode($data);
                } else {
                    if ($user->active != 1) {
                        $data['status'] = 2;
                    } else {
                        $data['status'] = 0;
                    }
                    $this->security->hash(rand());
                    echo json_encode($data);
                }

            } else {
                echo json_encode(['auth' => 0]);
            }
        } else {
            $this->response->redirect('index');
        }
    }

    /**
     * 设置session
     * @param Users $user
     */
    private function _registerSession(Users $user)
    {
        $this->session->set('auth', array(
            'id' => $user->id,
            'username' => $user->username,
            'role' => $user->role
        ));

    }

    /**
     * 登出
     */
    public function endAction()
    {
        //删除容器
        $client = new DockerClient([
            'remote_socket' => $this->config->application->dockerUri,
            'ssl' => $this->config->application->dockerSSL,
            'stream_context_options' => $this->config->application->dockerClientSSL->toArray(),
        ]);
        $docker = new Docker($client);
        $containerManager = $docker->getContainerManager();
        $removeInfo = array();
        $removeInfo['force'] = true;
        $container = Container::findFirst('user_id = ' . $this->session->get('auth')['id']);
        if ($container) {
            $containerManager->remove($container->container_id, $removeInfo);
            if (!$container->delete()) {
                echo "Sorry, we can't delete the robot right now: \n";

                foreach ($container->getMessages() as $message) {
                    echo $message, "\n";
                }
            } else {
                $etcdClient = new Client($this->config->application->etcdUri);
                $etcdClient->rm('/apps/' . substr(md5($container->container_id), 0, 16));
                $this->response->redirect('user/running');
            }
        }
        $this->session->remove('auth');
        $this->response->redirect('index');
    }

}

