<?php

use app\Service;
use DI\ContainerBuilder;
use Psr\Container\ContainerInterface;

return function (ContainerBuilder $containerBuilder) {
    $containerBuilder->addDefinitions([
        'db' => function (ContainerInterface $c) {
            $settings = $c->get('settings')['db'];
            $pdo = new PDO("pgsql:host={$settings['host']};port={$settings['port']};dbname={$settings['database']};user={$settings['user']};password={$settings['password']}");
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            return $pdo;
        },
        'service' => function (ContainerInterface $c) {
            return new Service($c->get('db'));
        },
    ]);
};
