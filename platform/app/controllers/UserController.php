<?php

use Docker\API\Model\ContainerConfig;
use Docker\API\Model\HostConfig;
use Docker\API\Model\PortBinding;
use Docker\Docker;
use Docker\DockerClient;
use LinkORB\Component\Etcd\Client;
use Phalcon\Mvc\View;

class UserController extends ControllerBase
{
    private $PORT = '80/tcp';
    private $etcdClient;

    public function initialize()
    {
        parent::initialize();
        $this->etcdClient = new Client($this->config->application->etcdUri);
    }

    public function indexAction()
    {

    }

    /**
     * 部署
     * @param $id
     */
    public function deployAction($id)
    {
        // ACL
        $user = Users::findFirst($this->session->get('auth')['id']);
        $courseacces_id = array();
        foreach ($user->courseaccess as $courseacces) {
            $courseacces_id[] = $courseacces->course_id;
        }
        $containers = Container::find("user_id = " . $this->session->get('auth')['id']);
        $this->view->disableLevel(View::LEVEL_MAIN_LAYOUT);
        $data = array();
        if (in_array($id, $courseacces_id) && (count($containers) === 0)) {
            $course = Courses::findFirst($id);
            $this->tag->setTitle($course->name);
            $this->view->course = $course;
            $client = new DockerClient([
                'remote_socket' => $this->config->application->dockerUri,
                'ssl' => $this->config->application->dockerSSL,
                'stream_context_options' => $this->config->application->dockerClientSSL->toArray(),
            ]);
            $docker = new Docker($client);
            $containerManager = $docker->getContainerManager();
            $containerConfig = new ContainerConfig();
            $containerConfig->setImage($course->image);
            $containerConfig->setAttachStdout(true);
            $containerConfig->setAttachStdin(true);
            $containerConfig->setAttachStderr(true);
            $containerConfig->setOpenStdin(true);
            $containerConfig->setTty(true);
            $exposedPorts = new \ArrayObject();
            $config = unserialize($course->config);
            if ($config['ports']) {
                $exposedPorts[$config['ports'][0]] = new \stdClass();
                $containerConfig->setExposedPorts($exposedPorts);
                $hostConfig = new HostConfig();
                $mapPorts = new \ArrayObject();
                $hostPortBinding = new PortBinding();
//            $hostPortBinding->setHostPort('32775');
                $hostPortBinding->setHostIp('0.0.0.0');
//            $mapPorts[$this->PORT] = [$hostPortBinding];
                $mapPorts[$config['ports'][0]] = [$hostPortBinding];
                $hostConfig->setPortBindings($mapPorts);
                $containerConfig->setHostConfig($hostConfig);
            }

//            $array = array();
//            $array['ports'] = array();
//            $array['ports'][] = '80/tcp';
//            var_dump(serialize($array));


            $containerCreateResult = $containerManager->create($containerConfig);
            $containerManager->start($containerCreateResult->getId());
            $result = $containerManager->find($containerCreateResult->getId());
//            $portBinding = $result->getNetworkSettings()->getPorts()[$this->PORT][0];
            if ($course->is_web == 1){
                if ($config['ports']) {
                    $portBinding = $result->getNetworkSettings()->getPorts()[$config['ports'][0]][0];
//                    $this->view->port = $portBinding->getHostPort();
//                    $this->view->address = $this->getServerIP();
                } else {
//                    $this->view->port = $result->getNetworkSettings()->getIPAddress();
//                    $this->view->address = substr(md5($containerCreateResult->getId()), 0, 16).".sxauweb.club";
                }
            }

            $this->view->container_id = $containerCreateResult->getId();

            if ($containerCreateResult->getId()) {
                $container = new Container();
                $container->user_id = $this->session->get('auth')['id'];
                $container->course_id = $id;
                $container->created_at = new Phalcon\Db\RawValue('now()');
                $container->image = $course->image;
                $container->status = 1;
                $container->port = $config['ports'] ? $portBinding->getHostPort() : $result->getNetworkSettings()->getIPAddress();
                $container->container_id = $containerCreateResult->getId();
                $container->domain = substr(md5($containerCreateResult->getId()), 0, 16);
                if (!$container->create()) {
                    echo "Umh, We can't store container right now: \n";
                    foreach ($container->getMessages() as $message) {
                        echo $message, "\n";
                    }
                }

//                $Parsedown = new Parsedown();
//                $this->view->report = $Parsedown->text($container->courses->report);
                $this->etcdClient->set('/apps/' . substr(md5($containerCreateResult->getId()), 0, 16), $result->getNetworkSettings()->getIPAddress());
                $data['status'] = 1;
                $data['is_web'] = $course->is_web;
                $data['container_id'] = $containerCreateResult->getId();
                if ($course->is_web){
                    $data['address'] = substr(md5($containerCreateResult->getId()), 0, 16).$this->config->application->site;
                } else {
                    $data['address'] = "www". $this->config->application->site ."/user/attach/" . $containerCreateResult->getId();
                }

            }
        } else {

            if (count($containers) !== 0) {
                $data['status'] = 10001;
                $data['message'] = "只能创建一个课程";
            } else {
                $data['status'] = 10002;
                $data['message'] = "对不起，没有相关权限。";
            }
        }
        $this->response->setContentType('application/json', 'UTF-8');
        echo json_encode($data);
    }

    public function getServerIP()
    {
        if (isset($_SERVER)) {
            if ($_SERVER['SERVER_ADDR']) {
                $server_ip = $_SERVER['SERVER_ADDR'];
            } else {
                $server_ip = $_SERVER['LOCAL_ADDR'];
            }
        } else {
            $server_ip = getenv('SERVER_ADDR');
        }
        return $server_ip;
    }

    /**
     * 控制台
     * @param $container_id
     */
    public function attachAction($container_id)
    {
        $container = Container::findFirst("container_id = '" . $container_id . "'");
        if ($container->user_id === $this->session->get('auth')['id']) {
//            $Parsedown = new Parsedown();
            $user = Users::findFirst($this->session->get('auth')['id']);
            $courseacces_id = array();
            foreach ($user->courseaccess as $courseacces) {
                $courseacces_id[] = $courseacces->course_id;
            }
            if (in_array($container->course_id, $courseacces_id)) {
                $this->view->report = $container->courses->report;
            }
            //TODO 需修改配置
            $this->view->url = "ws://lysec.dbqf.xyz:4243/containers/" . $container_id . "/attach/ws?logs=0&stream=1&stdin=1&stdout=1&stderr=1";
        } else {
            echo "Permission denied";
            $this->view->disableLevel(View::LEVEL_MAIN_LAYOUT);
        }
    }

    /**
     * 课程详情
     * @param $id
     */
    public function courseAction($id)
    {
        if (intval($id)) {
            $course = Courses::findFirst("id = " . $id);
            $this->view->course = $course;
            $user = Users::findFirst($this->session->get('auth')['id']);
            $courseacces_id = array();
            foreach ($user->courseaccess as $courseacces) {
                $courseacces_id[] = $courseacces->course_id;
            }
            if (in_array($id, $courseacces_id)) {
                $this->view->report = $course->report;
                $this->view->analysis = $course->analysis;
            }
            $this->tag->setTitle($course->name);
        } else {
            $this->response->redirect('index/show404');
        }
    }

    /**
     * 正在运行的服务
     */
    public function runningAction()
    {
        $containers = Container::find("user_id = " . $this->session->get('auth')['id']);
        $this->view->site = $this->config->application->site;
        $this->view->containers = $containers;
    }

    /**
     * 停止容器
     * @param $id
     * @param $container_id
     */
    public function stopAction($id, $container_id)
    {
        if (!empty($id) && intval($id) && !empty($id)) {
            //TODO 判断权限
            //TODO 级别高
            $client = new DockerClient([
                'remote_socket' => $this->config->application->dockerUri,
                'ssl' => $this->config->application->dockerSSL,
                'stream_context_options' => $this->config->application->dockerClientSSL->toArray(),
            ]);
            $docker = new Docker($client);
            $containerManager = $docker->getContainerManager();
            $removeInfo = array();
            $removeInfo['force'] = true;
            $containerManager->remove($container_id, $removeInfo);
            $container = Container::findFirst('id = ' . $id);
            if ($container && ($container->user_id === $this->session->get('auth')['id'])) {
                if (!$container->delete()) {
                    echo "Sorry, we can't delete the container right now: \n";

                    foreach ($container->getMessages() as $message) {
                        echo $message, "\n";
                    }
                } else {
                    $this->etcdClient->rm('/apps/' . substr(md5($container_id), 0, 16));
                    $this->response->redirect('user/running');
                }
            }
        }
    }

    /**
     * 资料页
     */
    public function profileAction()
    {

    }

    /**
     * 资料更新
     */
    public function updateProfileAction()
    {
        if ($this->request->isPost()) {
            $oldpassword = $this->request->getPost("oldpassword");
            $password = $this->request->getPost("password");
            $confirmpassword = $this->request->getPost("confirmpassword");
            if (empty($oldpassword) || empty($password) || empty($confirmpassword)) {
                $this->flash->error("You don't have permission to access this area");
            }
            if ($password !== $confirmpassword) {
                $this->flash->error("密码不一致");
            } else {
                $correct = Users::findFirst("id = " . $this->session->get('auth')['id']);
                if (!$this->security->checkHash($oldpassword, $correct->password)) {
                    $this->flash->error("密码错误");
                } else {
                    $correct->password = $this->security->hash($password);
                    if (!$correct->save()) {
                        echo "Umh, We can't store profile right now: \n";
                        foreach ($correct->getMessages() as $message) {
                            echo $message, "\n";
                        }
                    } else {
                        $this->response->redirect('index');
                        $this->session->destroy();
                    }
                    $this->security->hash(rand());
                }
            }
        } else {
            $this->flash->error("You don't have permission to access this area");
        }
    }

}

