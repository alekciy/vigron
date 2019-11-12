<?php

namespace app\struct;

/**
 * Базовый класс отвечающий за заполнение структуры (анемичная модель).
 */
class BaseStruct
{
    public function __construct(array $valueList)
    {
        foreach ($valueList as $propertyName => $propertyValue) {
            if (property_exists($this, $propertyName)) {
                $this->$propertyName = $propertyValue;
            }
        }
    }
}