--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6 (Ubuntu 10.6-1.pgdg16.04+1)
-- Dumped by pg_dump version 10.6 (Ubuntu 10.6-1.pgdg16.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.money DROP CONSTRAINT IF EXISTS money_purse_id_fk;
DROP INDEX IF EXISTS public.purse_id_uindex;
DROP INDEX IF EXISTS public.money_id_uindex;
DROP INDEX IF EXISTS public.exchange_currency_uindex;
ALTER TABLE IF EXISTS ONLY public.purse DROP CONSTRAINT IF EXISTS user_id;
ALTER TABLE IF EXISTS ONLY public.purse DROP CONSTRAINT IF EXISTS purse_pk;
ALTER TABLE IF EXISTS ONLY public.money DROP CONSTRAINT IF EXISTS money_pk;
ALTER TABLE IF EXISTS public.purse ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.money ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.purse_id_seq;
DROP TABLE IF EXISTS public.purse;
DROP SEQUENCE IF EXISTS public.money_id_seq;
DROP TABLE IF EXISTS public.money;
DROP TABLE IF EXISTS public.exchange;
DROP TYPE IF EXISTS public.transaction_type;
DROP TYPE IF EXISTS public.reason;
DROP TYPE IF EXISTS public.currency;
DROP EXTENSION IF EXISTS plpgsql;
DROP SCHEMA IF EXISTS public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: currency; Type: TYPE; Schema: public; Owner: vigron
--

CREATE TYPE public.currency AS ENUM (
    'RUB',
    'USD'
);


ALTER TYPE public.currency OWNER TO vigron;

--
-- Name: reason; Type: TYPE; Schema: public; Owner: vigron
--

CREATE TYPE public.reason AS ENUM (
    'stock',
    'refund'
);


ALTER TYPE public.reason OWNER TO vigron;

--
-- Name: transaction_type; Type: TYPE; Schema: public; Owner: vigron
--

CREATE TYPE public.transaction_type AS ENUM (
    'debit',
    'credit'
);


ALTER TYPE public.transaction_type OWNER TO vigron;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: exchange; Type: TABLE; Schema: public; Owner: vigron
--

CREATE TABLE public.exchange (
    currency public.currency NOT NULL,
    exchange numeric(6,2)
);


ALTER TABLE public.exchange OWNER TO vigron;

--
-- Name: TABLE exchange; Type: COMMENT; Schema: public; Owner: vigron
--

COMMENT ON TABLE public.exchange IS 'Курсы валют';


--
-- Name: COLUMN exchange.currency; Type: COMMENT; Schema: public; Owner: vigron
--

COMMENT ON COLUMN public.exchange.currency IS 'Валюта';


--
-- Name: COLUMN exchange.exchange; Type: COMMENT; Schema: public; Owner: vigron
--

COMMENT ON COLUMN public.exchange.exchange IS 'Курс относительно рубля';


--
-- Name: money; Type: TABLE; Schema: public; Owner: vigron
--

CREATE TABLE public.money (
    id integer NOT NULL,
    purse_id integer NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    money numeric(10,2) NOT NULL,
    currency public.currency NOT NULL,
    reason public.reason,
    type public.transaction_type NOT NULL
);


ALTER TABLE public.money OWNER TO vigron;

--
-- Name: TABLE money; Type: COMMENT; Schema: public; Owner: vigron
--

COMMENT ON TABLE public.money IS 'Денежные операции с кошельком';


--
-- Name: COLUMN money.created_at; Type: COMMENT; Schema: public; Owner: vigron
--

COMMENT ON COLUMN public.money.created_at IS 'Момент создания';


--
-- Name: COLUMN money.money; Type: COMMENT; Schema: public; Owner: vigron
--

COMMENT ON COLUMN public.money.money IS 'Сумма';


--
-- Name: COLUMN money.currency; Type: COMMENT; Schema: public; Owner: vigron
--

COMMENT ON COLUMN public.money.currency IS 'Валюта';


--
-- Name: COLUMN money.reason; Type: COMMENT; Schema: public; Owner: vigron
--

COMMENT ON COLUMN public.money.reason IS 'Причина изменения';


--
-- Name: COLUMN money.type; Type: COMMENT; Schema: public; Owner: vigron
--

COMMENT ON COLUMN public.money.type IS 'Тип операции';


--
-- Name: money_id_seq; Type: SEQUENCE; Schema: public; Owner: vigron
--

CREATE SEQUENCE public.money_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.money_id_seq OWNER TO vigron;

--
-- Name: money_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vigron
--

ALTER SEQUENCE public.money_id_seq OWNED BY public.money.id;


--
-- Name: purse; Type: TABLE; Schema: public; Owner: vigron
--

CREATE TABLE public.purse (
    id integer NOT NULL,
    currency public.currency NOT NULL,
    money numeric(10,2) NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.purse OWNER TO vigron;

--
-- Name: TABLE purse; Type: COMMENT; Schema: public; Owner: vigron
--

COMMENT ON TABLE public.purse IS 'Кошелек пользователя';


--
-- Name: COLUMN purse.currency; Type: COMMENT; Schema: public; Owner: vigron
--

COMMENT ON COLUMN public.purse.currency IS 'Валюта';


--
-- Name: COLUMN purse.money; Type: COMMENT; Schema: public; Owner: vigron
--

COMMENT ON COLUMN public.purse.money IS 'Баланс';


--
-- Name: COLUMN purse.user_id; Type: COMMENT; Schema: public; Owner: vigron
--

COMMENT ON COLUMN public.purse.user_id IS 'Идентификатор пользователя';


--
-- Name: purse_id_seq; Type: SEQUENCE; Schema: public; Owner: vigron
--

CREATE SEQUENCE public.purse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purse_id_seq OWNER TO vigron;

--
-- Name: purse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vigron
--

ALTER SEQUENCE public.purse_id_seq OWNED BY public.purse.id;


--
-- Name: money id; Type: DEFAULT; Schema: public; Owner: vigron
--

ALTER TABLE ONLY public.money ALTER COLUMN id SET DEFAULT nextval('public.money_id_seq'::regclass);


--
-- Name: purse id; Type: DEFAULT; Schema: public; Owner: vigron
--

ALTER TABLE ONLY public.purse ALTER COLUMN id SET DEFAULT nextval('public.purse_id_seq'::regclass);


--
-- Data for Name: exchange; Type: TABLE DATA; Schema: public; Owner: vigron
--

COPY public.exchange (currency, exchange) FROM stdin;
\.


--
-- Data for Name: money; Type: TABLE DATA; Schema: public; Owner: vigron
--

COPY public.money (id, purse_id, created_at, money, currency, reason, type) FROM stdin;
\.


--
-- Data for Name: purse; Type: TABLE DATA; Schema: public; Owner: vigron
--

COPY public.purse (id, currency, money, user_id) FROM stdin;
1	RUB	0.00	1
3	USD	0.00	2
\.


--
-- Name: money_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vigron
--

SELECT pg_catalog.setval('public.money_id_seq', 1, false);


--
-- Name: purse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vigron
--

SELECT pg_catalog.setval('public.purse_id_seq', 3, true);


--
-- Name: money money_pk; Type: CONSTRAINT; Schema: public; Owner: vigron
--

ALTER TABLE ONLY public.money
    ADD CONSTRAINT money_pk PRIMARY KEY (id);


--
-- Name: purse purse_pk; Type: CONSTRAINT; Schema: public; Owner: vigron
--

ALTER TABLE ONLY public.purse
    ADD CONSTRAINT purse_pk PRIMARY KEY (id);


--
-- Name: purse user_id; Type: CONSTRAINT; Schema: public; Owner: vigron
--

ALTER TABLE ONLY public.purse
    ADD CONSTRAINT user_id UNIQUE (user_id, currency);


--
-- Name: exchange_currency_uindex; Type: INDEX; Schema: public; Owner: vigron
--

CREATE UNIQUE INDEX exchange_currency_uindex ON public.exchange USING btree (currency);


--
-- Name: money_id_uindex; Type: INDEX; Schema: public; Owner: vigron
--

CREATE UNIQUE INDEX money_id_uindex ON public.money USING btree (id);


--
-- Name: purse_id_uindex; Type: INDEX; Schema: public; Owner: vigron
--

CREATE UNIQUE INDEX purse_id_uindex ON public.purse USING btree (id);


--
-- Name: money money_purse_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: vigron
--

ALTER TABLE ONLY public.money
    ADD CONSTRAINT money_purse_id_fk FOREIGN KEY (purse_id) REFERENCES public.purse(id) ON DELETE RESTRICT;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

