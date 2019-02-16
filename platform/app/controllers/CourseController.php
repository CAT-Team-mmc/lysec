<?php

use Docker\Docker;
use Docker\DockerClient;

/**
 * Class CourseController
 */
class CourseController extends AdminController
{

    public function indexAction()
    {

    }

    /**
     * 新建课程
     */
    public function newAction()
    {
        $client = new DockerClient([
            'remote_socket' => $this->config->application->dockerUri,
            'ssl' => $this->config->application->dockerSSL,
            'stream_context_options' => $this->config->application->dockerClientSSL->toArray(),
        ]);
        $docker = new Docker($client);
        $imageManager = $docker->getImageManager();
        $images = array();
        foreach ($imageManager->findAll() as $key => $imageItem) {
            foreach ($imageItem->getRepoTags() as $name) {
                $images[] = $name;
            }
        }
        $this->view->categorys = CourseCategory::find();
        $this->view->images = $images;
        $this->tag->setTitle("Add a course.");
    }

    /**
     * 新建课程的处理
     */
    public function createAction()
    {
        if (!$this->request->isPost()) {
            $this->dispatcher->forward(array(
                "controller" => "course",
                "action" => "new"
            ));
        }

        $course = new Courses();

        $course->name = $this->request->getPost("name", "striptags");
        $course->description = $this->request->getPost("description", "striptags");
        $course->image = $this->request->getPost("image", "striptags");
        $course->category = $this->request->getPost("category", "int");
        $course->report = $this->request->getPost("report");
        $course->url = $this->request->getPost("url", "striptags");
        $course->analysis = $this->request->getPost("analysis");
        $course->afterclass = $this->request->getPost("afterclass");
        if ($this->request->getPost("public") === "on") {
            $course->state = 1;
        } else {
            $course->state = 0;
        }
        if ($this->request->getPost("is_web") === "on") {
            $course->is_web = 1;
        } else {
            $course->is_web = 0;
        }

        $course->created_at = new Phalcon\Db\RawValue('now()');
        if (!$course->create()) {
            echo "Umh, We can't store course right now: \n";
            foreach ($course->getMessages() as $message) {
                echo $message, "\n";
            }
        } else {
            $this->response->redirect('admin/index');
        }
    }

    /**
     * 编辑课程
     * @param $id
     */
    public function editAction($id)
    {
        if (!intval($id)) {
            $this->response->redirect('index/show404');
        }

        $course = Courses::findFirst($id);
        $client = new DockerClient([
            'remote_socket' => $this->config->application->dockerUri,
            'ssl' => $this->config->application->dockerSSL,
            'stream_context_options' => $this->config->application->dockerClientSSL->toArray(),
        ]);
        $docker = new Docker($client);
        $imageManager = $docker->getImageManager();
        $images = array();
        foreach ($imageManager->findAll() as $key => $imageItem) {
            foreach ($imageItem->getRepoTags() as $name) {
                $images[] = $name;
            }
        }
        $this->view->categorys = CourseCategory::find();
        $this->view->images = $images;
        $this->view->course = $course;
        $this->tag->setTitle("Edit a course.");
    }

    /**
     * 编辑课程的处理
     */
    public function editHandleAction()
    {
        if (!$this->request->isPost()) {
            $this->dispatcher->forward(array(
                "controller" => "index",
                "action" => "show404"
            ));
        }
        $id = $this->request->getPost("course_id", "int");
        //TODO 需要防止CSRF
        $course = Courses::findFirst($id);

        $course->name = $this->request->getPost("name", "striptags");
        $course->description = $this->request->getPost("description", "striptags");
        $course->image = $this->request->getPost("image", "striptags");
        $course->category = $this->request->getPost("category", "int");
        $course->report = $this->request->getPost("report");
        $course->url = $this->request->getPost("url", "striptags");
        $course->analysis = $this->request->getPost("analysis");
        $course->afterclass = $this->request->getPost("afterclass");
        if ($this->request->getPost("public") === "on") {
            $course->state = 1;
        } else {
            $course->state = 0;
        }
        if ($this->request->getPost("is_web") === "on") {
            $course->is_web = 1;
        } else {
            $course->is_web = 0;
        }

        $course->created_at = new Phalcon\Db\RawValue('now()');
        if (!$course->save()) {
            echo "Umh, We can't store course right now: \n";
            foreach ($course->getMessages() as $message) {
                echo $message, "\n";
            }
        } else {
            $this->response->redirect('admin/index');
        }
    }

    /**
     * 删除课程
     * @param $id
     */
    public function deleteAction($id)
    {
        if (!intval($id)) {
            $this->response->redirect('index/show404');
        }

        $course = Courses::findFirst($id);

        if ($course) {
            if (!$course->delete()) {
                echo "Sorry, we can't delete the course right now: \n";

                foreach ($course->getMessages() as $message) {
                    echo $message, "\n";
                }
            } else {
                $this->response->redirect('admin/index');
            }
        }
    }

}

