<?php

use DI\ContainerBuilder;

// Настройки приложения
return function (ContainerBuilder $containerBuilder) {
    $containerBuilder->addDefinitions([
        'settings' => [
            'db' => [
                'host' => '127.0.0.1',
                'port' => 5432,
                'user' => 'vigron',
                'password' => 'xa8Ooxay',
                'database' => 'vigron',
            ],
        ],
    ]);
};
