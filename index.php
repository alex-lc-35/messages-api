<?php
$db = require __DIR__ . '/db.php';

$users = $db->select('demo', ['id', 'message']);

$res = "";
foreach ($users as $user) {
    $res .= $user['id'] . "\t" . $user['message'] . "\n";
}

echo nl2br($res);
