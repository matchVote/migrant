--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.11
-- Dumped by pg_dump version 9.6.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts (
    id integer NOT NULL,
    account_type text NOT NULL,
    user_id uuid,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: articles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.articles (
    id integer NOT NULL,
    url text NOT NULL,
    title text,
    authors character varying[] DEFAULT '{}'::character varying[],
    publisher text NOT NULL,
    date_published timestamp without time zone,
    keywords character varying[] DEFAULT '{}'::character varying[],
    summary text,
    read_time integer,
    newsworthiness_count integer DEFAULT 0,
    top_image_url text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    source text,
    read_count integer DEFAULT 0
);


--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.articles_id_seq OWNED BY public.articles.id;


--
-- Name: articles_representatives; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.articles_representatives (
    id integer NOT NULL,
    representative_id uuid,
    article_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    mentioned_count integer DEFAULT 0
);


--
-- Name: articles_representatives_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.articles_representatives_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: articles_representatives_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.articles_representatives_id_seq OWNED BY public.articles_representatives.id;


--
-- Name: bookmarks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bookmarks (
    id integer NOT NULL,
    article_id integer,
    user_id uuid,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: bookmarks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bookmarks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bookmarks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bookmarks_id_seq OWNED BY public.bookmarks.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    text text NOT NULL,
    user_id uuid,
    commentable_id integer,
    commentable_type character varying,
    likes integer DEFAULT 0,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contacts (
    id integer NOT NULL,
    emails text[],
    phone_numbers text[],
    contact_form_url text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    website_url text,
    contactable_id uuid,
    contactable_type character varying,
    external_ids public.hstore
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;


--
-- Name: inference_opinions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inference_opinions (
    id integer NOT NULL,
    agrees boolean,
    stance_id integer,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: inference_opinions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inference_opinions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inference_opinions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inference_opinions_id_seq OWNED BY public.inference_opinions.id;


--
-- Name: issue_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.issue_categories (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    keywords character varying[] DEFAULT '{}'::character varying[]
);


--
-- Name: issue_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.issue_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: issue_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.issue_categories_id_seq OWNED BY public.issue_categories.id;


--
-- Name: officials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.officials (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    bioguide_id character varying(255) NOT NULL,
    official_name text,
    first_name character varying(255),
    last_name character varying(255),
    middle_name character varying(255),
    nickname character varying(255),
    suffix character varying(255),
    birthday date,
    gender character varying(255),
    religion character varying(255),
    media jsonb,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: poll_responses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.poll_responses (
    id integer NOT NULL,
    response text,
    user_id uuid,
    representative_id uuid,
    article_id integer
);


--
-- Name: poll_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.poll_responses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: poll_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.poll_responses_id_seq OWNED BY public.poll_responses.id;


--
-- Name: postal_addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.postal_addresses (
    id integer NOT NULL,
    city text,
    state text,
    zip text,
    contact_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    line1 text,
    line2 text
);


--
-- Name: postal_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.postal_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: postal_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.postal_addresses_id_seq OWNED BY public.postal_addresses.id;


--
-- Name: relationships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.relationships (
    id integer NOT NULL,
    follower_id uuid,
    followed_id uuid,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.relationships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.relationships_id_seq OWNED BY public.relationships.id;


--
-- Name: representatives; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.representatives (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    bioguide_id text,
    title text,
    first_name text NOT NULL,
    last_name text NOT NULL,
    middle_name text,
    suffix text,
    official_full_name text,
    nickname text,
    birthday text,
    gender text,
    orientation text,
    government_role text,
    state text,
    state_rank text,
    district text,
    party text,
    branch text,
    religion text,
    status text,
    verified boolean,
    profile_image_url text,
    slug text NOT NULL,
    biography text,
    user_id integer,
    name_recognition bigint DEFAULT 0,
    seniority_date text,
    office text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settings (
    id integer NOT NULL,
    var character varying NOT NULL,
    value text,
    target_id integer NOT NULL,
    target_type character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;


--
-- Name: stance_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stance_events (
    id integer NOT NULL,
    action integer DEFAULT 0 NOT NULL,
    agreeance_value integer,
    importance_value integer,
    stance_id integer,
    statement_id integer,
    issue_category_id integer,
    opinionable_id uuid,
    opinionable_type character varying,
    created_by uuid,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: stance_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stance_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stance_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stance_events_id_seq OWNED BY public.stance_events.id;


--
-- Name: stance_quotes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stance_quotes (
    id integer NOT NULL,
    quote text,
    quote_url text,
    stance_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    quote_timestamp timestamp without time zone
);


--
-- Name: stance_quotes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stance_quotes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stance_quotes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stance_quotes_id_seq OWNED BY public.stance_quotes.id;


--
-- Name: stances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stances (
    id integer NOT NULL,
    agreeance_value integer,
    importance_value integer,
    skipped boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    opinionable_id uuid,
    opinionable_type character varying,
    inferred_by text,
    verified boolean,
    statement_id integer
);


--
-- Name: stances_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stances_id_seq OWNED BY public.stances.id;


--
-- Name: statements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.statements (
    id integer NOT NULL,
    text text NOT NULL,
    issue_category_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    lean text,
    lean_weight integer
);


--
-- Name: statements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.statements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: statements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.statements_id_seq OWNED BY public.statements.id;


--
-- Name: user_article_changes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_article_changes (
    id integer NOT NULL,
    article_id integer,
    user_id uuid,
    change_type text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: user_article_changes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_article_changes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_article_changes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_article_changes_id_seq OWNED BY public.user_article_changes.id;


--
-- Name: user_comment_changes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_comment_changes (
    id integer NOT NULL,
    comment_id integer,
    user_id uuid,
    change_type text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: user_comment_changes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_comment_changes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_comment_changes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_comment_changes_id_seq OWNED BY public.user_comment_changes.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    username character varying,
    admin boolean,
    profile_type text,
    profile_id uuid,
    rep_admin boolean DEFAULT false,
    rep_slug text,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    personal_info public.hstore,
    profile_pic character varying,
    provider character varying,
    uid character varying
);


--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: articles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.articles ALTER COLUMN id SET DEFAULT nextval('public.articles_id_seq'::regclass);


--
-- Name: articles_representatives id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.articles_representatives ALTER COLUMN id SET DEFAULT nextval('public.articles_representatives_id_seq'::regclass);


--
-- Name: bookmarks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookmarks ALTER COLUMN id SET DEFAULT nextval('public.bookmarks_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- Name: inference_opinions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inference_opinions ALTER COLUMN id SET DEFAULT nextval('public.inference_opinions_id_seq'::regclass);


--
-- Name: issue_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_categories ALTER COLUMN id SET DEFAULT nextval('public.issue_categories_id_seq'::regclass);


--
-- Name: poll_responses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.poll_responses ALTER COLUMN id SET DEFAULT nextval('public.poll_responses_id_seq'::regclass);


--
-- Name: postal_addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.postal_addresses ALTER COLUMN id SET DEFAULT nextval('public.postal_addresses_id_seq'::regclass);


--
-- Name: relationships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationships ALTER COLUMN id SET DEFAULT nextval('public.relationships_id_seq'::regclass);


--
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- Name: stance_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stance_events ALTER COLUMN id SET DEFAULT nextval('public.stance_events_id_seq'::regclass);


--
-- Name: stance_quotes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stance_quotes ALTER COLUMN id SET DEFAULT nextval('public.stance_quotes_id_seq'::regclass);


--
-- Name: stances id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stances ALTER COLUMN id SET DEFAULT nextval('public.stances_id_seq'::regclass);


--
-- Name: statements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statements ALTER COLUMN id SET DEFAULT nextval('public.statements_id_seq'::regclass);


--
-- Name: user_article_changes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_article_changes ALTER COLUMN id SET DEFAULT nextval('public.user_article_changes_id_seq'::regclass);


--
-- Name: user_comment_changes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_comment_changes ALTER COLUMN id SET DEFAULT nextval('public.user_comment_changes_id_seq'::regclass);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: articles_representatives articles_representatives_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.articles_representatives
    ADD CONSTRAINT articles_representatives_pkey PRIMARY KEY (id);


--
-- Name: bookmarks bookmarks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookmarks
    ADD CONSTRAINT bookmarks_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: inference_opinions inference_opinions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inference_opinions
    ADD CONSTRAINT inference_opinions_pkey PRIMARY KEY (id);


--
-- Name: issue_categories issue_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_categories
    ADD CONSTRAINT issue_categories_pkey PRIMARY KEY (id);


--
-- Name: officials officials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.officials
    ADD CONSTRAINT officials_pkey PRIMARY KEY (id);


--
-- Name: poll_responses poll_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.poll_responses
    ADD CONSTRAINT poll_responses_pkey PRIMARY KEY (id);


--
-- Name: postal_addresses postal_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.postal_addresses
    ADD CONSTRAINT postal_addresses_pkey PRIMARY KEY (id);


--
-- Name: relationships relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT relationships_pkey PRIMARY KEY (id);


--
-- Name: representatives representatives_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.representatives
    ADD CONSTRAINT representatives_pkey PRIMARY KEY (id);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: stance_events stance_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stance_events
    ADD CONSTRAINT stance_events_pkey PRIMARY KEY (id);


--
-- Name: stance_quotes stance_quotes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stance_quotes
    ADD CONSTRAINT stance_quotes_pkey PRIMARY KEY (id);


--
-- Name: stances stances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stances
    ADD CONSTRAINT stances_pkey PRIMARY KEY (id);


--
-- Name: statements statements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statements
    ADD CONSTRAINT statements_pkey PRIMARY KEY (id);


--
-- Name: statements statements_text_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statements
    ADD CONSTRAINT statements_text_key UNIQUE (text);


--
-- Name: user_article_changes user_article_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_article_changes
    ADD CONSTRAINT user_article_changes_pkey PRIMARY KEY (id);


--
-- Name: user_comment_changes user_comment_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_comment_changes
    ADD CONSTRAINT user_comment_changes_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: article_changes_artID_userID_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "article_changes_artID_userID_type_idx" ON public.user_article_changes USING btree (article_id, user_id, change_type);


--
-- Name: idx_articles_reps_primary_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_articles_reps_primary_key ON public.articles_representatives USING btree (representative_id, article_id);


--
-- Name: index_accounts_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_user_id ON public.accounts USING btree (user_id);


--
-- Name: index_articles_on_title; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_articles_on_title ON public.articles USING btree (title);


--
-- Name: index_articles_on_url; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_articles_on_url ON public.articles USING btree (url);


--
-- Name: index_bookmarks_on_article_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bookmarks_on_article_id_and_user_id ON public.bookmarks USING btree (article_id, user_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_user_id ON public.comments USING btree (user_id);


--
-- Name: index_contacts_on_contactable_type_and_contactable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contacts_on_contactable_type_and_contactable_id ON public.contacts USING btree (contactable_type, contactable_id);


--
-- Name: index_inference_opinions_on_stance_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_inference_opinions_on_stance_id ON public.inference_opinions USING btree (stance_id);


--
-- Name: index_inference_opinions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_inference_opinions_on_user_id ON public.inference_opinions USING btree (user_id);


--
-- Name: index_issue_categories_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_issue_categories_on_name ON public.issue_categories USING btree (name);


--
-- Name: index_poll_responses_on_user_id_and_article_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_poll_responses_on_user_id_and_article_id ON public.poll_responses USING btree (user_id, article_id);


--
-- Name: index_postal_addresses_on_contact_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_postal_addresses_on_contact_id ON public.postal_addresses USING btree (contact_id);


--
-- Name: index_relationships_on_followed_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_relationships_on_followed_id ON public.relationships USING btree (followed_id);


--
-- Name: index_relationships_on_follower_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_relationships_on_follower_id ON public.relationships USING btree (follower_id);


--
-- Name: index_relationships_on_follower_id_and_followed_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_relationships_on_follower_id_and_followed_id ON public.relationships USING btree (follower_id, followed_id);


--
-- Name: index_representatives_on_first_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_representatives_on_first_name ON public.representatives USING btree (first_name);


--
-- Name: index_representatives_on_first_name_and_last_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_representatives_on_first_name_and_last_name ON public.representatives USING btree (first_name, last_name);


--
-- Name: index_representatives_on_last_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_representatives_on_last_name ON public.representatives USING btree (last_name);


--
-- Name: index_representatives_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_representatives_on_slug ON public.representatives USING btree (slug);


--
-- Name: index_representatives_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_representatives_on_user_id ON public.representatives USING btree (user_id);


--
-- Name: index_settings_on_target_type_and_target_id_and_var; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_settings_on_target_type_and_target_id_and_var ON public.settings USING btree (target_type, target_id, var);


--
-- Name: index_stance_events_on_created_by; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stance_events_on_created_by ON public.stance_events USING btree (created_by);


--
-- Name: index_stance_events_on_issue_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stance_events_on_issue_category_id ON public.stance_events USING btree (issue_category_id);


--
-- Name: index_stance_events_on_opinionable_type_and_opinionable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stance_events_on_opinionable_type_and_opinionable_id ON public.stance_events USING btree (opinionable_type, opinionable_id);


--
-- Name: index_stance_events_on_stance_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stance_events_on_stance_id ON public.stance_events USING btree (stance_id);


--
-- Name: index_stance_events_on_statement_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stance_events_on_statement_id ON public.stance_events USING btree (statement_id);


--
-- Name: index_stance_quotes_on_stance_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stance_quotes_on_stance_id ON public.stance_quotes USING btree (stance_id);


--
-- Name: index_stances_on_opinionable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stances_on_opinionable_id ON public.stances USING btree (opinionable_id);


--
-- Name: index_stances_on_opinionable_id_and_statement_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_stances_on_opinionable_id_and_statement_id ON public.stances USING btree (opinionable_id, statement_id);


--
-- Name: index_stances_on_opinionable_type_and_opinionable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stances_on_opinionable_type_and_opinionable_id ON public.stances USING btree (opinionable_type, opinionable_id);


--
-- Name: index_stances_on_statement_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stances_on_statement_id ON public.stances USING btree (statement_id);


--
-- Name: index_statements_on_issue_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_statements_on_issue_category_id ON public.statements USING btree (issue_category_id);


--
-- Name: index_user_comment_changes_on_comment_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_user_comment_changes_on_comment_id_and_user_id ON public.user_comment_changes USING btree (comment_id, user_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_provider ON public.users USING btree (provider);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_uid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_uid ON public.users USING btree (uid);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_username ON public.users USING btree (username);


--
-- Name: officials_bioguide_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX officials_bioguide_id_index ON public.officials USING btree (bioguide_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON public.schema_migrations USING btree (version);


--
-- Name: comments fk_rails_03de2dc08c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_03de2dc08c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: accounts fk_rails_b1e30bebc8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT fk_rails_b1e30bebc8 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20190205115900);

