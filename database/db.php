<?php

require __DIR__ . '/../vendor/autoload.php';

use Medoo\Medoo;
use Dotenv\Dotenv;

// Charge le fichier .env uniquement s’il existe (utile en local uniquement)
$envPath = __DIR__ . '/../.env';
if (file_exists($envPath)) {
    $dotenv = Dotenv::createImmutable(dirname($envPath));
    $dotenv->load();
}

// Création de la connexion via Medoo, en utilisant getenv() pour toutes les valeurs
return new Medoo([
    'type'     => 'mysql',
    'host'     => getenv('DB_HOST') ?: 'localhost',
    'database' => getenv('DB_NAME') ?: 'messages',
    'username' => getenv('DB_USER') ?: 'root',
    'password' => getenv('DB_PASS') ?: '',
    'charset'  => 'utf8mb4',
]);
