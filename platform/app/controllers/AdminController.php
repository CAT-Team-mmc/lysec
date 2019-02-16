<?php

use Docker\Docker;
use Docker\DockerClient;
use LinkORB\Component\Etcd\Client;
use Phalcon\Mvc\View;

/**
 * 管理员控制器
 * Class AdminController
 */
class AdminController extends ControllerBase
{

    /**
     * 管理员主界面
     */
    public function indexAction()
    {
        $this->tag->setTitle("Admin");
        $this->view->courses = Courses::find();
    }

    /**
     * 用户列表界面
     */
    public function usersAction()
    {
        $this->tag->setTitle("Users-Admin");
        $users = Users::find();
        $this->view->users = $users;
    }

    /**
     * 创建用户界面
     */
    public function userCreateAction()
    {
    }

    /**
     * 创建用户处理
     */
    public function userNewAction()
    {
        if ($this->request->isPost()) {
            $user = new Users();
            $user->username = $this->request->getPost("name", "striptags");
            $user->password = $this->security->hash($this->request->getPost("password", "striptags"));
            $user->email = $this->request->getPost("email", "striptags");
            $user->role = $this->request->getPost("role", "striptags");
            $user->phone = $this->request->getPost("phone", "int");
            $user->pay_flag = $this->request->getPost("pay_flag", "int");
            $user->active = "1";
            $user->created_at = new Phalcon\Db\RawValue('now()');
            if (!$user->create()) {
                echo "Umh, We can't store user right now: \n";
                foreach ($user->getMessages() as $message) {
                    echo $message, "\n";
                }
            } else {
                $this->response->redirect('admin/users');
            }
        } else {
            $this->response->redirect('admin/users');
        }
    }

    /**
     * QA问答
     */
    public function qaAction()
    {
        $qas = Qa::find();
        $this->view->qas = $qas;
    }

    /**
     * 增加QA
     */
    public function addQAAction()
    {
        if ($this->request->isPost()) {
            $qa = new Qa();
            $qa->meta_key = $this->request->getPost("question", "striptags");
            $qa->meta_value = $this->request->getPost("answer");
            $qa->type = "qa";
            if (!$qa->create()) {
                echo "Umh, We can't store qa right now: \n";
                foreach ($qa->getMessages() as $message) {
                    echo $message, "\n";
                }
            } else {
                $this->response->redirect('admin/qa');
            }
        }
    }

    /**
     * editQA
     */
    public function editQAAction($id)
    {
        if (intval($id)) {
            $qa = Qa::findFirst($id);
            if ($this->request->isPost()) {
                $qa->meta_key = $this->request->getPost("question", "striptags");
                $qa->meta_value = $this->request->getPost("answer");
                $qa->type = "qa";
                if (!$qa->save()) {
                    echo "Umh, We can't store qa right now: \n";
                    foreach ($qa->getMessages() as $message) {
                        echo $message, "\n";
                    }
                } else {
                    $this->response->redirect('admin/qa');
                }
            } else {
                $this->view->qa = $qa;
            }
        }
    }

    /**
     * 删除QA
     * @param $id
     */
    public function removeQAAction($id)
    {
        if (intval($id)) {
            $qa = Qa::findFirst($id);

            if ($qa) {
                if (!$qa->delete()) {
                    echo "Sorry, we can't delete the qa right now: \n";
                    foreach ($qa->getMessages() as $message) {
                        echo $message, "\n";
                    }
                } else {
                    $this->response->redirect('admin/qa');
                }
            }
        }
    }

    /**
     * 查看用户开放的课程
     * @param $id 用户id
     */
    public function userCourseAction($id)
    {
        if (intval($id)) {
            $user = Users::findFirst($id);
            $this->view->user = $user;
            $this->view->courses = Courses::find();
            $courseacces_id = array();
            foreach ($user->courseaccess as $courseacces) {
                $courseacces_id[] = $courseacces->course_id;
            }
            $this->view->courseacsses_ids = $courseacces_id;
        } else {
            $this->response->redirect('index/show404');
        }
    }

    /**
     * 重置密码
     * @param $user_id
     */
    public function resetPasswordAction($user_id)
    {
        if (intval($user_id)) {
            $user = Users::findFirst($user_id);
            $str = substr(md5(time()), 0, 10);
            echo $str;
            $user->password = $this->security->hash($str);
//            $mail = new PHPMailer;
////$mail->SMTPDebug = 3;                               // Enable verbose debug output
//            $mail->isSMTP();                                      // Set mailer to use SMTP
//            $mail->Host = 'smtp1.example.com;smtp2.example.com';  // Specify main and backup SMTP servers
//            $mail->SMTPAuth = true;                               // Enable SMTP authentication
//            $mail->Username = 'user@example.com';                 // SMTP username
//            $mail->Password = 'secret';                           // SMTP password
//            $mail->SMTPSecure = 'tls';                            // Enable TLS encryption, `ssl` also accepted
//            $mail->Port = 587;                                    // TCP port to connect to
//            $mail->setFrom('test@lysec.org', 'Lysec');
//            $mail->addAddress('joe@example.net', 'Joe User');     // Add a recipient
//            $mail->isHTML(true);                                  // Set email format to HTML
//            $mail->Subject = '请查收您的重置密码';
//            $mail->Body = '您的密码为<b>' . $str . '</b>, 请尽快登陆重置';
//
//            if (!$mail->send()) {
//                echo 'Message could not be sent.';
//                echo 'Mailer Error: ' . $mail->ErrorInfo;
//            } else {
//                echo 'Message has been sent';
//            }
            if (!$user->save()) {
                echo "Umh, We can't store profile right now: \n";
                foreach ($user->getMessages() as $message) {
                    echo $message, "\n";
                }
            } else {
                $sc = new \SendCloud\SendCloud();
                // 参数1为module名称, 参数2为action名称, 参数3为请求参数,它们将作为POST数据提交给接口
                $req = $sc->prepare('mail', 'send', array(
                    'api_user' => 'dubuqingfeng_test_DcLtxk',
                    'api_key' => 'LSYoClZE5qzYtpSO',
                    'from' => 'test@lysec.org',
                    'to' => $user->email,
                    'subject' => '请查收您的重置密码',
                    'html' => '您的密码为' . $str . ', 请尽快登陆重置',
                    'apiUser' => 'dubuqingfeng_test_DcLtxk',
                    'apiKey' => 'LSYoClZE5qzYtpSO',
                ));
                // 提交API调用请求,返回数据
                $req->send();
            }
        } else {
            $this->response->redirect('index/show404');
        }
    }

    /**
     * 授权课程
     * @param $user_id
     * @param $course_id
     */
    public function authorizeAction($user_id, $course_id)
    {
        if (intval($user_id) && intval($course_id)) {
            $course_access = new CourseAccess();
            $course_access->user_id = $user_id;
            $course_access->course_id = $course_id;
            $course_access->created_at = new Phalcon\Db\RawValue('now()');

            if (!$course_access->create()) {
                echo "Umh, We can't store course_access right now: \n";
                foreach ($course_access->getMessages() as $message) {
                    echo $message, "\n";
                }
            } else {
                $this->response->redirect('admin/userCourse/' . $user_id);
            }
        } else {
            $this->response->redirect('index/show404');
        }
    }

    /**
     * 取消授权
     * @param $user_id
     * @param $course_id
     */
    public function unauthorizeAction($user_id, $course_id)
    {
        if (intval($user_id) && intval($course_id)) {
            //绑定查询，避免SQL注入
            $conditions = "course_id = :course_id: AND user_id = :user_id:";

            $parameters = array(
                "course_id" => $course_id,
                "user_id" => $user_id
            );

            $course_access = CourseAccess::findFirst(
                array(
                    $conditions,
                    "bind" => $parameters
                )
            );
            if (!$course_access->delete()) {
                echo "Umh, We can't store course_access right now: \n";
                foreach ($course_access->getMessages() as $message) {
                    echo $message, "\n";
                }
            } else {
                $this->response->redirect('admin/userCourse/' . $user_id);
            }
        } else {
            $this->response->redirect('index/show404');
        }
    }

    /**
     * 增加分类
     * @param $cate_name
     */
    public function addCategoryAction($cate_name)
    {
        $cate_name = $this->filter->sanitize($cate_name, "string");
        $category = new CourseCategory();
        $category->cate_name = $cate_name;
        $category->sort_order = 100;
        $category->code = "";
        $category->parent_id = 0;
        $data = array();
        $this->view->disableLevel(View::LEVEL_MAIN_LAYOUT);
        if (!$category->create()) {
            $data['state'] = 0;
        } else {
            $data['state'] = 1;
            $data['result'] = $category->id;
        }
        echo json_encode($data);
    }

    /**
     * 用户付费
     * @param $user_id
     * @param $pay_flag
     */
    public function userPayAction($pay_flag, $user_id)
    {
        $user_id = $this->filter->sanitize($user_id, "int");
        $user = Users::findFirst("id = ". $user_id);
        $user->pay_flag = $this->filter->sanitize($pay_flag, "int");
        $this->view->disableLevel(View::LEVEL_MAIN_LAYOUT);
        if (!$user->save()) {
            $data['state'] = 0;
        } else {
            $data['state'] = 1;
        }
        echo json_encode($data);
    }

    /**
     * 监控页面
     */
    public function monitorAction()
    {
        $containers = Container::find();
        $this->view->containers = $containers;
    }

    /**
     * 停止容器
     * @param $container_id
     */
    public function stopContainerAction($container_id)
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
        $container = Container::findFirst('container_id = "' . $container_id .'"');
        $this->view->disableLevel(View::LEVEL_MAIN_LAYOUT);
        if ($container) {
            $containerManager->remove($container_id, $removeInfo);
            if (!$container->delete()) {
                echo "Sorry, we can't delete the container right now: \n";
                foreach ($container->getMessages() as $message) {
                    echo $message, "\n";
                }
            } else {
                $etcdClient = new Client($this->config->application->etcdUri);
                $etcdClient->rm('/apps/' . substr(md5($container_id), 0, 16));
                $this->response->redirect('admin/monitor');
            }
        }
    }

    /**
     * 分类列表
     */
    public function categoriesAction()
    {

        $categories = CourseCategory::find([
            "order" => "sort_order",
        ]);
        $this->view->categories = $categories;
    }

    /**
     * 删除分类
     * @param $cate_id
     */
    public function deleteCategoryAction($cate_id)
    {
        if (intval($cate_id)) {
            $category = CourseCategory::findFirst('id = ' . $cate_id);
            if (!$category->delete()) {
                echo "Sorry, we can't delete the category right now: \n";

                foreach ($category->getMessages() as $message) {
                    echo $message, "\n";
                }
            } else {
                $this->response->redirect('admin/categories');
            }
        }
    }

    /**
     * 编辑分类页面
     * @param $cate_id
     */
    public function editCategoryAction($cate_id)
    {
        if (intval($cate_id)) {
            $category = CourseCategory::findFirst('id = ' . $cate_id);
            $this->view->category = $category;
        }
    }

    /**
     * 编辑分类处理
     */
    public function editCategoryHandleAction()
    {
        $category_id = $this->request->getPost("category_id", "int");
        $category = CourseCategory::findFirst('id = ' . $category_id);


        $category->cate_name = $this->request->getPost("name", "striptags");
        $category->sort_order = $this->request->getPost("sort_order", "int");

        if (!$category->save()) {
            echo "Umh, We can't store category right now: \n";
            foreach ($category->getMessages() as $message) {
                echo $message, "\n";
            }
        } else {
            $this->response->redirect('admin/categories');
        }
    }

    /**
     * 禁止用户登陆
     * @param $user_id
     */
    public function banUserLoginAction($user_id)
    {
        $user_id = $this->filter->sanitize($user_id, "int");
        $user = Users::findFirst("id = ". $user_id);
        $user->active = 0;
        $this->view->disableLevel(View::LEVEL_MAIN_LAYOUT);
        if (!$user->save()) {
            $data['state'] = 0;
        } else {
            $data['state'] = 1;
        }
        echo json_encode($data);
    }

    /**
     * 允许用户登陆
     * @param $user_id
     */
    public function allowUserLoginAction($user_id)
    {
        $user_id = $this->filter->sanitize($user_id, "int");
        $user = Users::findFirst("id = ". $user_id);
        $user->active = 1;
        $this->view->disableLevel(View::LEVEL_MAIN_LAYOUT);
        if (!$user->save()) {
            $data['state'] = 0;
        } else {
            $data['state'] = 1;
        }
        echo json_encode($data);
    }
}

