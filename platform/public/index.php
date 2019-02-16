<?php
use Phalcon\Di\FactoryDefault;

error_reporting(E_ALL);

//是否开启调试
define('APP_DEBUG', true);
if (APP_DEBUG) {
    $debug = new \Phalcon\Debug();
    $debug->listen();
}


define('APP_PATH', realpath('..'));

try {

    /**
     * The FactoryDefault Dependency Injector automatically register the right services providing a full stack framework
     */
    $di = new FactoryDefault();

    /**
     * Read services
     */
    include APP_PATH . "/app/config/services.php";

    /**
     * composer autoload
     */
    require_once APP_PATH . "/vendor/autoload.php";

    /**
     * Call the autoloader service.  We don't need to keep the results.
     */
    $di->getLoader();
    /**
     * https://github.com/fabfuel/prophiler
     */
//    $profiler = new \Fabfuel\Prophiler\Profiler();
//    $di->setShared('profiler', $profiler);
//    $pluginManager = new \Fabfuel\Prophiler\Plugin\Manager\Phalcon($profiler);
//    $pluginManager->register();

    /**
     * Handle the request
     */
    $application = new \Phalcon\Mvc\Application($di);

    echo $application->handle()->getContent();

} catch (\Exception $e) {
    echo $e->getMessage() . '<br>';
    echo '<pre>' . $e->getTraceAsString() . '</pre>';
}
