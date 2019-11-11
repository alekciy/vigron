<?php

use DI\ContainerBuilder;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;
use Slim\Middleware\BodyParsingMiddleware;
use Slim\Middleware\ErrorMiddleware;

require __DIR__ . '/../vendor/autoload.php';

// Контейнер
$containerBuilder = new ContainerBuilder();
// Настройки
$settings = require __DIR__ . '/../app/settings.php';
$settings($containerBuilder);

// Зависимости
$dependencies = require __DIR__ . '/../app/dependencies.php';
$dependencies($containerBuilder);

// Создаем приложение
AppFactory::setContainer($containerBuilder->build());
$app = AppFactory::create();

$app
    ->add((new ErrorMiddleware(
        $app->getCallableResolver(),
        $app->getResponseFactory(),
        true,
        false,
        false
    )))->add(new BodyParsingMiddleware());

$app->get('/purse/{id}', function (Request $request, Response $response, $args) {
    return $response;
});
$app->post('/purse/{id}', function (Request $request, Response $response, $args) {
    /** @var \app\Service $srv */
    $srv = $this->get('service');
    $response->getBody()->write( json_encode($srv->getPurseList()) );
    return $response;
});

$app->run();
