<?php

use Phalcon\Paginator\Adapter\Model as PaginatorModel;
use Phalcon\Mvc\View;

/**
 * 首页及一些异常，QA，课程的控制器
 * Class IndexController
 */
class IndexController extends ControllerBase
{

    /**
     * 首页控制器
     */
    public function indexAction()
    {
        $this->tag->setTitle($this->view->t->_('index_index_h4_sub_title'));
        $this->view->courses = Courses::find("state=1");
    }

    /**
     * QA控制器
     */
    public function qaAction()
    {
        $this->tag->setTitle("问与答");
        $qa = Qa::find(["type='qa'", "order" => "sort_order",]);
        $this->view->qas = $qa;
    }

    /**
     * 课程控制器
     * @param int $currentPage 分页参数
     */
    public function coursesAction($currentPage = 1)
    {
        $this->tag->setTitle("课程列表");
        $search = $this->request->getQuery("search", "string", "");

        $courses = Courses::find(
            array(
                "conditions" => "name LIKE '%" . $search . "%' AND state = 1",
            )
        );
        $paginator = new PaginatorModel(
            array(
                "data" => $courses,
                "limit" => 16,
                "page" => $currentPage
            )
        );
        $page = $paginator->getPaginate();
        $this->view->page = $page;
        $categories = CourseCategory::find([
            "order" => "sort_order",
        ]);
        $this->view->categories = $categories;
        $this->view->top_categories = CourseCategory::find([
            "order" => "sort_order",
            "limit" => 4,
        ]);
    }

    /**
     * 课程控制器
     * @param int $currentPage 分页参数
     */
    public function searchAction($currentPage = 1)
    {
        $search = $this->request->getQuery("search", "string", "");

        $courses = Courses::find(
            array(
                "conditions" => "name LIKE '%" . $search . "%' AND state = 1",
            )
        );
        $paginator = new PaginatorModel(
            array(
                "data" => $courses,
                "limit" => 16,
                "page" => $currentPage
            )
        );
        $page = $paginator->getPaginate();
        $this->view->page = $page;
        $this->view->search = $search;
    }

    public function coursesJSONAction()
    {
        $search = $this->request->getQuery("search", "string", "");
        $category = $this->request->getQuery("category", "int", "");
        $currentPage = $this->request->getQuery("cur_page", "int", 1);
        $category_and = $category ? "AND category = " . $category : "";

        $courses = Courses::find(
            array(
                "conditions" => "name LIKE '%" . $search . "%' AND state = 1 " . $category_and,
            )
        );
        $paginator = new PaginatorModel(
            array(
                "data" => $courses,
                "limit" => 16,
                "page" => $currentPage
            )
        );

        $this->view->disableLevel(View::LEVEL_MAIN_LAYOUT);
        $array = array(
            "status" => 1,
            "page" => $paginator->getPaginate()
        );
        echo json_encode($array);
    }

    /**
     * 404页面
     */
    public function show404Action()
    {
        $this->response->setStatusCode(404, "404 Not Found");
    }

    /**
     * 503页面
     */
    public function show503Action()
    {
        $this->response->setStatusCode(503, "Internal Server Error");
    }

    /**
     * 401页面
     */
    public function show401Action()
    {
        $this->response->setStatusCode(401, "Unauthorized");
    }

}

