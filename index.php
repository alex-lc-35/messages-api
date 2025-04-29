<?php
$db = require __DIR__ . '/database/db.php';

$messages = $db->select('messages', ['id', 'content']);

$res = "";
foreach ($messages as $message) {
    $res .= $message['id'] . "\t" . $message['content'] . "\n";
}

echo nl2br($res);
