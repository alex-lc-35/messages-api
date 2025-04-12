<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
header('Access-Control-Allow-Methods: GET, POST');

$db = require __DIR__ . '/database/db.php';
$table = 'messages';

// Récupérer la méthode HTTP
$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    $messages = $db->select($table, ['id', 'type', 'content']);
    echo json_encode([
        'success' => true,
        'data' => $messages,
    ]);
    exit;
}

if ($method === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);

    if (!isset($input['type']) || !isset($input['content'])) {
        http_response_code(400);
        echo json_encode([
            'success' => false,
            'error' => 'Missing type or content',
        ]);
        exit;
    }

    $db->insert($table, [
        'type' => $input['type'],
        'content' => $input['content'],
    ]);

    echo json_encode(['success' => true]);
    exit;
}

// Si la méthode n’est pas gérée
http_response_code(405);
echo json_encode(['error' => 'Method not allowed']);
