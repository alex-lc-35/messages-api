<?php

require_once __DIR__ . '/common.php';

$getResponse = get('hello?name=Alice');
$postResponse = post('hello', ['name' => 'Bob']);



echo "<h2>GET</h2>";
var_dump($getResponse);

echo "<h2>POST</h2>";
var_dump($postResponse);
