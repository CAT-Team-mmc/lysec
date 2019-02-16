<?php
/**
 * Created by PhpStorm.
 * User: user
 * Date: 16-8-2
 */
use Phalcon\Acl;
use Phalcon\Acl\Adapter\Memory as AclList;
use Phalcon\Acl\Resource;
use Phalcon\Acl\Role;
use Phalcon\Events\Event;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Mvc\User\Plugin;

/**
 * SecurityPlugin
 *
 * This is the security plugin which controls that users only have access to the modules they're assigned to
 */
class SecurityPlugin extends Plugin
{
    /**
     * This action is executed before execute any action in the application
     *
     * @param Event $event
     * @param Dispatcher $dispatcher
     * @return bool
     */
    public function beforeDispatch(Event $event, Dispatcher $dispatcher)
    {
        $auth = $this->session->get('auth');

        if (!$auth) {
            $role = 'Guests';
        } else {
            if ($auth['role'] === "admin" || $auth['role'] === "Admin") {
                $role = 'Admin';
            } else {
                $role = 'Users';
            }
        }
        $controller = $dispatcher->getControllerName();
        $action = $dispatcher->getActionName();
        $acl = $this->getAcl();
        if (!$acl->isResource($controller)) {
            $dispatcher->forward([
                'controller' => 'index',
                'action' => 'show404'
            ]);
            return false;
        }
        $allowed = $acl->isAllowed($role, $controller, $action);
        if ($allowed != Acl::ALLOW) {
            $dispatcher->forward(array(
                'controller' => 'index',
                'action' => 'show401'
            ));
//            $this->session->destroy();
            return false;
        }
    }

    /**
     * Returns an existing or new access control list
     *
     * @returns AclList
     */
    public function getAcl()
    {
        if (!isset($this->persistent->acl)) {
            $acl = new AclList();
            $acl->setDefaultAction(Acl::DENY);
            // Register roles
            $roles = [
                'users' => new Role(
                    'Users',
                    'Member privileges, granted after sign in.'
                ),
                'admin' => new Role(
                    'Admin',
                    'Admin privileges.'
                ),
                'guests' => new Role(
                    'Guests',
                    'Anyone browsing the site who is not signed in is considered to be a "Guest".'
                )
            ];
            foreach ($roles as $role) {
                $acl->addRole($role);
            }
            //Private area resources
            $privateResources = array(
//                'invoices'     => array('index', 'profile')
                'index' => array('index', 'courses', 'coursesJSON', 'search'),
                'user' => array('index', 'deploy', 'course', 'running', 'profile', 'updateProfile', 'stop', 'attach')
            );
            foreach ($privateResources as $resource => $actions) {
                $acl->addResource(new Resource($resource), $actions);
            }
            //Public area resources
            $publicResources = array(
                'register' => array('index'),
                'index' => array('index', 'show401', 'show404', 'show503', 'qa'),
                'login' => array('index', 'register', 'start', 'end', 'captcha'),
            );
            foreach ($publicResources as $resource => $actions) {
                $acl->addResource(new Resource($resource), $actions);
            }
            //Admin area resources
            $adminResources = array(
                'admin' => array('index', 'qa', 'addQA', 'editQA', 'removeQA', 'userCourse', 'users', 'authorize', 'userCreate', 'userNew', 'resetPassword', 'unauthorize', 'addCategory', 'monitor', 'stopContainer', 'categories', 'deleteCategory', 'editCategory', 'editCategoryHandle', 'userPay', 'banUserLogin', 'allowUserLogin'),
                'index' => array('index', 'courses', 'coursesJSON', 'search'),
                'user' => array('index', 'deploy', 'course', 'running', 'profile', 'updateProfile', 'stop', 'attach'),
                'course' => array('new', 'create', 'delete', 'edit', 'editHandle'),
                'image' => array('index', 'create', 'info', 'delete'),
            );
            foreach ($adminResources as $resource => $actions) {
                $acl->addResource(new Resource($resource), $actions);
            }
            //Grant access to public areas to both users and guests
            foreach ($roles as $role) {
                foreach ($publicResources as $resource => $actions) {
                    foreach ($actions as $action) {
                        $acl->allow($role->getName(), $resource, $action);
                    }
                }
            }
            //Grant access to private area to role Users
            foreach ($privateResources as $resource => $actions) {
                foreach ($actions as $action) {
                    $acl->allow('Users', $resource, $action);
                }
            }
            foreach ($adminResources as $resource => $actions) {
                foreach ($actions as $action) {
                    $acl->allow('Admin', $resource, $action);
                }
            }
            //The acl is stored in session, APC would be useful here too
            $this->persistent->acl = $acl;
        }
        return $this->persistent->acl;
    }
}