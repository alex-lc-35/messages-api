<?php

$db = require __DIR__ . '/db.php';

// Supprimer la table si elle existe
$db->query("DROP TABLE IF EXISTS messages");

// Créer la table proprement
$db->query("
    CREATE TABLE messages (
        id INT AUTO_INCREMENT PRIMARY KEY,
        type VARCHAR(20) NOT NULL,
        content TEXT NOT NULL
    )
");

$db->query("
    INSERT INTO sandbox_api.messages (type, content)
    VALUES ('success', 'Lorem ipsum');
    
    INSERT INTO sandbox_api.messages (type, content)
    VALUES ('danger', 'Ipsum lorem');
");

echo "✅ Table 'messages' supprimée et recréée avec succès.\n";
