<?php
require __DIR__ . '/vendor/autoload.php';

use Medoo\Medoo;

return new Medoo([
    'type' => 'mysql',
    'host' => 'sandbox-mysql',
    'database' => 'shared_db',
    'username' => 'user',
    'password' => 'password',
    'charset' => 'utf8mb4'
]);
