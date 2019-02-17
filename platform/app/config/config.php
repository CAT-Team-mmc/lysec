<?php

defined('APP_PATH') || define('APP_PATH', realpath('.'));

$isLocal = (in_array($_SERVER["SERVER_ADDR"], array("127.0.0.1", "::1")) || strpos($_SERVER["SERVER_ADDR"], '192.168') !== false) ? true : false;

$isProduction = ($_SERVER['HTTP_HOST'] == 'www.sxauweb.club') ? true : false;

//if ($isLocal) {
//}

return new \Phalcon\Config([
    'database' => [
        'adapter' => 'Mysql',
        'host' => $isLocal?'127.0.0.1':'127.0.0.1',
        'username' => 'root',
        'password' => 'lysec',
        'dbname' => 'platform',
        'charset' => 'utf8',
    ],
    'application' => [
        'controllersDir' => APP_PATH . '/app/controllers/',
        'modelsDir' => APP_PATH . '/app/models/',
        'migrationsDir' => APP_PATH . '/app/migrations/',
        'viewsDir' => APP_PATH . '/app/views/',
        'pluginsDir' => APP_PATH . '/app/plugins/',
        'libraryDir' => APP_PATH . '/app/library/',
        'cacheDir' => APP_PATH . '/app/cache/',
        'baseUri' => '/',
        'site' => '.lysec.org',
        'etcdUri' => 'http://127.0.0.1:2379',
        'dockerUri' => 'tcp://127.0.0.1:4243',
        'dockerSSL' => false,
        'dockerClientSSL' => [
            'ssl' => [
                'cafile' => '/home/user/docker/ca.pem',
                'local_cert' => '/home/user/docker/client-cert.pem',
                'local_pk' => '/home/user/docker/client-key.pem',
                'verify_peer_name' => true,
                'allow_self_signed' => true,
            ],
        ],
        'CAPTCHA_ID' => '9503459f710c28680a8b64e85b4592ef',
        'CAPTCHA_PRIVATE_KEY' => '89cb574617a9a1f7c53c0c5aa789de90',
    ]
]);
