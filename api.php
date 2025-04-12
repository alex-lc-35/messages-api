<?php
// Autorise les appels depuis tous les domaines (ou remplace * par projet5.traefik.me)
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

// Optionnel : autoriser certaines méthodes si tu veux gérer POST plus tard
header('Access-Control-Allow-Methods: GET');

// Ta logique API habituelle
$db = require __DIR__ . '/database/db.php';

$messages = $db->select('messages', ['id','type', 'content']);

echo json_encode([
    'success' => true,
    'data' => $messages,
]);
