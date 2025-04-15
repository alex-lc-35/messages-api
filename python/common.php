<?php

const BASE_URL = 'http://sandbox-python:5000/';

function get(string $endpoint) {
    $url = BASE_URL . ltrim($endpoint, '/');
    $response = @file_get_contents($url);

    if ($response === false) {
        return ['error' => 'Failed to contact Python microservice'];
    }

    return json_decode($response, true);
}

function post(string $endpoint, array $payload) {
    $url = BASE_URL . ltrim($endpoint, '/');
    $data = json_encode($payload);

    $options = [
        "http" => [
            "header"  => "Content-Type: application/json\r\n",
            "method"  => "POST",
            "content" => $data,
        ]
    ];

    $context = stream_context_create($options);
    $response = @file_get_contents($url, false, $context);

    if ($response === false) {
        return ['error' => 'Failed to contact Python microservice'];
    }

    return json_decode($response, true);
}
