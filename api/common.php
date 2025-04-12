<?php

header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
header('Access-Control-Allow-Methods: GET, POST');

require_once __DIR__ . '/../vendor/autoload.php';

/**
 * Fournit une instance unique de Medoo
 */
function getDb() {
    static $db = null;

    if ($db === null) {
        $db = require __DIR__ . '/../database/db.php';
    }

    return $db;
}

/**
 * Récupère les données JSON envoyées via POST
 */
function getJsonInput() {
    return json_decode(file_get_contents('php://input'), true);
}

/**
 * Renvoie une réponse JSON
 */
function jsonResponse($data, $statusCode = 200) {
    http_response_code($statusCode);
    echo json_encode($data);
    exit;
}
