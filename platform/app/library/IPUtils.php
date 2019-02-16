<?php

/**
 * Created by PhpStorm.
 * User: user
 * Date: 16-9-17
 * Time: 下午2:31
 */
class IPUtils
{
    public static function get_client_ip()
    {
        global $ip;

        if (getenv("HTTP_CLIENT_IP"))
            $ip = getenv("HTTP_CLIENT_IP");
        else if (getenv("HTTP_X_FORWARDED_FOR"))
            $ip = getenv("HTTP_X_FORWARDED_FOR");
        else if (getenv("REMOTE_ADDR"))
            $ip = getenv("REMOTE_ADDR");
        else
            $ip = "Unknow";

        return $ip;
    }
}