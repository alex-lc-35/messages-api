<?php
$db = require __DIR__ . '/database/db.php';

$messages = $db->select('messages', ['id', 'content']);

$res = "";
foreach ($messages as $user) {
    $res .= $user['id'] . "\t" . $user['content'] . "\n";
}

echo nl2br($res);
