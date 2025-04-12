<?php

require __DIR__ . '/common.php';

$db = getDb();
$method = $_SERVER['REQUEST_METHOD'];
$table = 'messages';


if ($method === 'GET') {
    $data = $db->select($table, ['id', 'type', 'content']);
    jsonResponse(['success' => true, 'data' => $data]);
}

if ($method === 'POST') {
    $input = getJsonInput();

    if (!isset($input['type'], $input['content'])) {
        jsonResponse(['success' => false, 'error' => 'Missing type or content'], 400);
    }

    $db->insert($table, [
        'type' => $input['type'],
        'content' => $input['content'],
    ]);

    jsonResponse(['success' => true]);
}

jsonResponse(['error' => 'Method not allowed'], 405);
