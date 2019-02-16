<?php
use Docker\Docker;
use Docker\DockerClient;

/**
 * 后台镜像管理控制器
 * Class ImageController
 */
class ImageController extends AdminController
{
    private $client;
    private $imageManager;

    public function initialize()
    {
        $this->view->username = $this->session->get('auth')['username'];
        $this->client = new DockerClient([
            'remote_socket' => $this->config->application->dockerUri,
            'ssl' => $this->config->application->dockerSSL,
            'stream_context_options' => $this->config->application->dockerClientSSL->toArray(),
        ]);
        $docker = new Docker($this->client);
        $this->imageManager = $docker->getImageManager();
        $this->view->t    = $this->getTranslation();
    }

    /**
     * 镜像管理界面
     */
    public function indexAction()
    {
        $this->tag->setTitle("Images-Admin");
        $images = array();
        foreach ($this->imageManager->findAll() as $key => $imageItem)
        {
            $images[$key]['id'] = $imageItem->getId();
            $images[$key]['create'] = $imageItem->getCreated();
            $images[$key]['size'] = round($imageItem->getSize() / 1000 / 1000, 2);
            $images[$key]['tag'] = $imageItem->getRepoTags();
        }
        $this->view->images = $images;
    }

    /**
     * 镜像详情
     */
    public function infoAction()
    {

    }

    /**
     * 移除镜像
     */
    public function deleteAction($id)
    {
        if (!empty($id)) {
            $removeInfo = array();
            $removeInfo['force'] = false;
            $this->imageManager->remove(explode(":", $id)[1], $removeInfo);
            $this->response->redirect('image/index');
        }
    }

    /**
     * 拉取镜像
     */
    public function createAction()
    {
        if ($this->request->isPost()) {
            $name = $this->request->getPost("name");
            if (!empty($name)) {
                $imageName = explode(":", $name);
                $image = array();
                $image['fromImage'] = $imageName[0];
                $image['tag'] = $imageName[1] ? $imageName[1] : 'latest';
                $createImageInfo = $this->imageManager->create("", $image);
//                $result = array();
                foreach ($createImageInfo as $key => $item) {
                    echo $item->getStatus();
                    echo "<br>";
                }
            } else {
                echo "is empty";
            }
        } else {
            $this->response->redirect('image/index');
        }
    }

}

