<?php

namespace app;

/**
 * Сервис с логикой.
 */
class Service
{
    /** @var \PDO */
    protected $db;

    /**
     * @param \PDO $connect
     */
    public function __construct(\PDO $connect)
    {
        $this->db = $connect;
    }

    public function getPurseList()
    {
        return $this->db->query('SELECT * FROM purse')->fetchAll();
    }
}