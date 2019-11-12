<?php

namespace app\struct;

/**
 * Структура связанная с транзакцией.
 */
class Money extends BaseStruct

{
    public $id = 0;
    public $purseId = 0;
    public $createdAt = null;
    public $money = 0.0;
    public $currency = '';
    public $reason = '';
    public $type = '';
}