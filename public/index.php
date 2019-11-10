<?php

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;
use Slim\Middleware\BodyParsingMiddleware;
use Slim\Middleware\ErrorMiddleware;

require __DIR__ . '/../vendor/autoload.php';

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

});
$app->post('/purse', function (Request $request, Response $response, $args) {

});

$app->run();
