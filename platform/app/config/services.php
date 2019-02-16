<?php

use Phalcon\Dispatcher;
use Phalcon\Events\Manager as EventsManager;
use Phalcon\Flash\Direct as Flash;
use Phalcon\Mvc\Dispatcher as MvcDispatcher;
use Phalcon\Mvc\Dispatcher\Exception as DispatchException;
use Phalcon\Mvc\Model\Metadata\Memory as MetaDataAdapter;
use Phalcon\Mvc\Url as UrlResolver;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Session\Adapter\Files as SessionAdapter;

/**
 * Shared configuration service
 */
$di->setShared('config', function () {
    return include APP_PATH . "/app/config/config.php";
});

/**
 * Shared loader service
 */
$di->setShared('loader', function () {
    $config = $this->getConfig();

    /**
     * Include Autoloader
     */
    include APP_PATH . '/app/config/loader.php';

    return $loader;
});

/**
 * The URL component is used to generate all kind of urls in the application
 */
$di->setShared('url', function () {
    $config = $this->getConfig();

    $url = new UrlResolver();
    $url->setBaseUri($config->application->baseUri);

    return $url;
});

/**
 * Setting up the view component
 */
$di->setShared('view', function () {
    $config = $this->getConfig();

    $view = new View();
    $view->setViewsDir($config->application->viewsDir);

    $view->registerEngines([
        '.volt' => function ($view, $di) {
            $config = $this->getConfig();

            $volt = new VoltEngine($view, $di);

            $volt->setOptions([
                'compiledPath' => $config->application->cacheDir,
                'compiledSeparator' => '_'
            ]);

            return $volt;
        },
        '.phtml' => 'Phalcon\Mvc\View\Engine\Php'
    ]);

    return $view;
});


/**
 * Database connection is created based in the parameters defined in the configuration file
 */
$di->setShared('db', function () use($di) {
    $config = $this->getConfig();

    $dbConfig = $config->database->toArray();
    $adapter = $dbConfig['adapter'];
    unset($dbConfig['adapter']);

    $class = 'Phalcon\Db\Adapter\Pdo\\' . $adapter;

    return new $class($dbConfig);
});

/**
 * If the configuration specify the use of metadata adapter use it or use memory otherwise
 */
$di->setShared('modelsMetadata', function () {
    return new MetaDataAdapter();
});

/**
 * Register the session flash service with the Twitter Bootstrap classes
 */
$di->set('flash', function () {
//    return new Flash([
//        'error' => 'alert alert-danger',
//        'success' => 'alert alert-success',
//        'notice' => 'alert alert-info',
//        'warning' => 'alert alert-warning'
//    ]);
    return new Flash();
});

/**
 * Start the session the first time some component request the session service
 */
$di->setShared('session', function () {
    // Set the max lifetime of a session with 'ini_set()' to two hour
    ini_set('session.gc_maxlifetime', 7200);
    session_set_cookie_params(7200);

    $session = new SessionAdapter();
    $session->start();

    return $session;
});

$di->set('dispatcher', function () {

    // 创建一个事件管理
    $eventsManager = new EventsManager();

    $eventsManager->attach('dispatch:beforeDispatch', new SecurityPlugin);
    // 附上一个侦听者
    $eventsManager->attach("dispatch:beforeException", new ExceptionsPlugin);

    $dispatcher = new MvcDispatcher();

    // 将EventsManager绑定到调度器
    $dispatcher->setEventsManager($eventsManager);

    return $dispatcher;

}, true);