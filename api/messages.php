<?php

require __DIR__ . '/common.php';

$db = getDb();
$method = $_SERVER['REQUEST_METHOD'];
$table = 'messages';

try {
    match ($method) {
        'GET'  => isset($_GET['id']) ? show($db, $table) : index($db, $table),
        'POST' => store($db, $table),
        default => jsonResponse(['error' => 'Method not allowed'], 405),
    };
} catch (Exception $e) {
    jsonResponse(['success' => false, 'error' => $e->getMessage()], 500);
}

function index($db, $table): void
{
    $messages = $db->select($table, ['id', 'type', 'content']);
    jsonResponse(['success' => true, 'data' => $messages]);
}

function show($db, $table): void
{
    $id = (int) $_GET['id'];
    $message = $db->get($table, ['id', 'type', 'content'], ['id' => $id]);

    if ($message) {
        jsonResponse(['success' => true, 'data' => $message]);
    } else {
        jsonResponse(['success' => false, 'error' => 'Message not found'], 404);
    }
}

function store($db, $table): void
{
    $input = getJsonInput();

    if (!isset($input['type'], $input['content'])) {
        jsonResponse(['success' => false, 'error' => 'Missing type or content'], 400);
    }

    $db->insert($table, [
        'type' => $input['type'],
        'content' => $input['content'],
    ]);

    $id = $db->id();

    $message = $db->get($table, ['id', 'type', 'content'], ['id' => $id]);

    jsonResponse([
        'success' => true,
        'message' => 'Message added successfully',
        'data' => $message
    ]);
}
