--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.4
-- Dumped by pg_dump version 9.5.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
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
-- Name: intarray; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS intarray WITH SCHEMA public;


--
-- Name: EXTENSION intarray; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION intarray IS 'functions, operators, and index support for 1-D arrays of integers';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE active_admin_comments (
    id integer NOT NULL,
    resource_id character varying(255) NOT NULL,
    resource_type character varying(255) NOT NULL,
    author_id integer,
    author_type character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    namespace character varying(255)
);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE active_admin_comments_id_seq OWNED BY active_admin_comments.id;


--
-- Name: cmsimple_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cmsimple_images (
    id integer NOT NULL,
    attachment character varying(255),
    width character varying(255),
    height character varying(255),
    file_size character varying(255),
    content_type character varying(255),
    title character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: cmsimple_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cmsimple_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cmsimple_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cmsimple_images_id_seq OWNED BY cmsimple_images.id;


--
-- Name: cmsimple_pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cmsimple_pages (
    id integer NOT NULL,
    uri character varying(255) NOT NULL,
    template character varying(255),
    content text,
    title character varying(255),
    parent_id integer,
    "position" integer DEFAULT 0,
    slug character varying(255),
    is_root boolean DEFAULT false,
    keywords character varying(255),
    description text,
    browser_title character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    published_at timestamp without time zone
);


--
-- Name: cmsimple_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cmsimple_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cmsimple_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cmsimple_pages_id_seq OWNED BY cmsimple_pages.id;


--
-- Name: cmsimple_paths; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cmsimple_paths (
    id integer NOT NULL,
    uri character varying(255),
    redirect_uri character varying(255),
    page_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: cmsimple_paths_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cmsimple_paths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cmsimple_paths_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cmsimple_paths_id_seq OWNED BY cmsimple_paths.id;


--
-- Name: cmsimple_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cmsimple_versions (
    id integer NOT NULL,
    content text,
    template character varying(255),
    published_at timestamp without time zone,
    page_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: cmsimple_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cmsimple_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cmsimple_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cmsimple_versions_id_seq OWNED BY cmsimple_versions.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE comments (
    id integer NOT NULL,
    user_id integer,
    submission_id integer,
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: newsletter_signups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE newsletter_signups (
    id integer NOT NULL,
    email character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: newsletter_signups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE newsletter_signups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: newsletter_signups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE newsletter_signups_id_seq OWNED BY newsletter_signups.id;


--
-- Name: registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE registrations (
    id integer NOT NULL,
    user_id integer,
    year integer,
    contact_email character varying(255),
    zip character varying(255),
    company character varying(255),
    gender character varying(255),
    primary_role character varying(255),
    track_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    calendar_token character varying(255)
);


--
-- Name: registrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE registrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: registrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE registrations_id_seq OWNED BY registrations.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: session_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE session_registrations (
    id integer NOT NULL,
    registration_id integer,
    submission_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: session_registrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE session_registrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: session_registrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE session_registrations_id_seq OWNED BY session_registrations.id;


--
-- Name: sponsor_signups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sponsor_signups (
    id integer NOT NULL,
    contact_name character varying(255),
    contact_email character varying(255),
    company character varying(255),
    interest text,
    notes text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sponsor_signups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sponsor_signups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sponsor_signups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sponsor_signups_id_seq OWNED BY sponsor_signups.id;


--
-- Name: submissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE submissions (
    id integer NOT NULL,
    submitter_id integer,
    track_id integer,
    format character varying(255),
    location character varying(255),
    time_range character varying(255),
    title character varying(255),
    description text,
    notes text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    contact_email character varying(255),
    estimated_size character varying(255),
    is_confirmed boolean DEFAULT false NOT NULL,
    is_public boolean DEFAULT true NOT NULL,
    venue_id integer,
    volunteers_needed integer,
    budget_needed integer,
    start_hour double precision DEFAULT 0 NOT NULL,
    end_hour double precision DEFAULT 0 NOT NULL,
    year integer,
    state character varying(255),
    start_day integer,
    end_day integer,
    internal_notes text,
    slides_url character varying,
    video_url character varying
);


--
-- Name: submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE submissions_id_seq OWNED BY submissions.id;


--
-- Name: tracks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tracks (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    icon character varying(255),
    email_alias character varying(255),
    display_order integer DEFAULT 0 NOT NULL,
    is_submittable boolean DEFAULT false NOT NULL,
    description text
);


--
-- Name: tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tracks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tracks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tracks_id_seq OWNED BY tracks.id;


--
-- Name: tracks_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tracks_users (
    track_id integer,
    user_id integer
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    uid character varying(255),
    name character varying(255),
    email character varying(255),
    description character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    provider character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: venues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE venues (
    id integer NOT NULL,
    name character varying(255),
    description text,
    contact_name character varying(255),
    contact_email character varying(255),
    contact_phone character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    address character varying(255),
    city character varying(255),
    state character varying(255)
);


--
-- Name: venues_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE venues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: venues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE venues_id_seq OWNED BY venues.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit character varying(255),
    object text,
    created_at timestamp without time zone
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: volunteer_signups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE volunteer_signups (
    id integer NOT NULL,
    contact_name character varying(255),
    contact_email character varying(255),
    interest text,
    notes text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: volunteer_signups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE volunteer_signups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: volunteer_signups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE volunteer_signups_id_seq OWNED BY volunteer_signups.id;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE votes (
    id integer NOT NULL,
    user_id integer,
    submission_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE votes_id_seq OWNED BY votes.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY active_admin_comments ALTER COLUMN id SET DEFAULT nextval('active_admin_comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cmsimple_images ALTER COLUMN id SET DEFAULT nextval('cmsimple_images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cmsimple_pages ALTER COLUMN id SET DEFAULT nextval('cmsimple_pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cmsimple_paths ALTER COLUMN id SET DEFAULT nextval('cmsimple_paths_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cmsimple_versions ALTER COLUMN id SET DEFAULT nextval('cmsimple_versions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY newsletter_signups ALTER COLUMN id SET DEFAULT nextval('newsletter_signups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY registrations ALTER COLUMN id SET DEFAULT nextval('registrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY session_registrations ALTER COLUMN id SET DEFAULT nextval('session_registrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sponsor_signups ALTER COLUMN id SET DEFAULT nextval('sponsor_signups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY submissions ALTER COLUMN id SET DEFAULT nextval('submissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tracks ALTER COLUMN id SET DEFAULT nextval('tracks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY venues ALTER COLUMN id SET DEFAULT nextval('venues_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY volunteer_signups ALTER COLUMN id SET DEFAULT nextval('volunteer_signups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY votes ALTER COLUMN id SET DEFAULT nextval('votes_id_seq'::regclass);


--
-- Name: admin_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY active_admin_comments
    ADD CONSTRAINT admin_notes_pkey PRIMARY KEY (id);


--
-- Name: cmsimple_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cmsimple_images
    ADD CONSTRAINT cmsimple_images_pkey PRIMARY KEY (id);


--
-- Name: cmsimple_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cmsimple_pages
    ADD CONSTRAINT cmsimple_pages_pkey PRIMARY KEY (id);


--
-- Name: cmsimple_paths_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cmsimple_paths
    ADD CONSTRAINT cmsimple_paths_pkey PRIMARY KEY (id);


--
-- Name: cmsimple_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cmsimple_versions
    ADD CONSTRAINT cmsimple_versions_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: newsletter_signups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY newsletter_signups
    ADD CONSTRAINT newsletter_signups_pkey PRIMARY KEY (id);


--
-- Name: registrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY registrations
    ADD CONSTRAINT registrations_pkey PRIMARY KEY (id);


--
-- Name: session_registrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY session_registrations
    ADD CONSTRAINT session_registrations_pkey PRIMARY KEY (id);


--
-- Name: sponsor_signups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sponsor_signups
    ADD CONSTRAINT sponsor_signups_pkey PRIMARY KEY (id);


--
-- Name: submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tracks
    ADD CONSTRAINT tracks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: venues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (id);


--
-- Name: versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: volunteer_signups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY volunteer_signups
    ADD CONSTRAINT volunteer_signups_pkey PRIMARY KEY (id);


--
-- Name: votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: fulltext_submissions_description_english; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fulltext_submissions_description_english ON submissions USING gin (to_tsvector('english'::regconfig, description));


--
-- Name: fulltext_submissions_title_english; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fulltext_submissions_title_english ON submissions USING gin (to_tsvector('english'::regconfig, (title)::text));


--
-- Name: fulltext_users_name_english; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fulltext_users_name_english ON users USING gin (to_tsvector('english'::regconfig, (name)::text));


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_namespace ON active_admin_comments USING btree (namespace);


--
-- Name: index_admin_notes_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_notes_on_resource_type_and_resource_id ON active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_cmsimple_pages_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cmsimple_pages_on_parent_id ON cmsimple_pages USING btree (parent_id);


--
-- Name: index_cmsimple_pages_on_path; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cmsimple_pages_on_path ON cmsimple_pages USING btree (uri);


--
-- Name: index_cmsimple_pages_on_published_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cmsimple_pages_on_published_at ON cmsimple_pages USING btree (published_at);


--
-- Name: index_cmsimple_versions_on_page_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cmsimple_versions_on_page_id ON cmsimple_versions USING btree (page_id);


--
-- Name: index_cmsimple_versions_on_published_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cmsimple_versions_on_published_at ON cmsimple_versions USING btree (published_at);


--
-- Name: index_comments_on_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_submission_id ON comments USING btree (submission_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_user_id ON comments USING btree (user_id);


--
-- Name: index_registrations_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_registrations_on_user_id ON registrations USING btree (user_id);


--
-- Name: index_session_registrations_on_registration_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_session_registrations_on_registration_id ON session_registrations USING btree (registration_id);


--
-- Name: index_session_registrations_on_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_session_registrations_on_submission_id ON session_registrations USING btree (submission_id);


--
-- Name: index_submissions_on_submitter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_submissions_on_submitter_id ON submissions USING btree (submitter_id);


--
-- Name: index_submissions_on_track_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_submissions_on_track_id ON submissions USING btree (track_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_item_type_and_item_id ON versions USING btree (item_type, item_id);


--
-- Name: index_votes_on_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_votes_on_submission_id ON votes USING btree (submission_id);


--
-- Name: index_votes_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_votes_on_user_id ON votes USING btree (user_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20130116164738');

INSERT INTO schema_migrations (version) VALUES ('20130116164739');

INSERT INTO schema_migrations (version) VALUES ('20130116164740');

INSERT INTO schema_migrations (version) VALUES ('20130116164741');

INSERT INTO schema_migrations (version) VALUES ('20130116164742');

INSERT INTO schema_migrations (version) VALUES ('20130116164743');

INSERT INTO schema_migrations (version) VALUES ('20130116164744');

INSERT INTO schema_migrations (version) VALUES ('20130116164745');

INSERT INTO schema_migrations (version) VALUES ('20130116164746');

INSERT INTO schema_migrations (version) VALUES ('20130116164747');

INSERT INTO schema_migrations (version) VALUES ('20130116164748');

INSERT INTO schema_migrations (version) VALUES ('20130117040102');

INSERT INTO schema_migrations (version) VALUES ('20130508051211');

INSERT INTO schema_migrations (version) VALUES ('20130511175418');

INSERT INTO schema_migrations (version) VALUES ('20130511175511');

INSERT INTO schema_migrations (version) VALUES ('20130512230944');

INSERT INTO schema_migrations (version) VALUES ('20130514013000');

INSERT INTO schema_migrations (version) VALUES ('20130528190244');

INSERT INTO schema_migrations (version) VALUES ('20130601210506');

INSERT INTO schema_migrations (version) VALUES ('20130621041352');

INSERT INTO schema_migrations (version) VALUES ('20130624052955');

INSERT INTO schema_migrations (version) VALUES ('20130624062458');

INSERT INTO schema_migrations (version) VALUES ('20130624062459');

INSERT INTO schema_migrations (version) VALUES ('20130624065911');

INSERT INTO schema_migrations (version) VALUES ('20130624155048');

INSERT INTO schema_migrations (version) VALUES ('20130624155135');

INSERT INTO schema_migrations (version) VALUES ('20130717031259');

INSERT INTO schema_migrations (version) VALUES ('20130717164913');

INSERT INTO schema_migrations (version) VALUES ('20130717170045');

INSERT INTO schema_migrations (version) VALUES ('20130718145826');

INSERT INTO schema_migrations (version) VALUES ('20130723182248');

INSERT INTO schema_migrations (version) VALUES ('20130730175935');

INSERT INTO schema_migrations (version) VALUES ('20130806165927');

INSERT INTO schema_migrations (version) VALUES ('20130813182826');

INSERT INTO schema_migrations (version) VALUES ('20130814182029');

INSERT INTO schema_migrations (version) VALUES ('20130814183554');

INSERT INTO schema_migrations (version) VALUES ('20130815173006');

INSERT INTO schema_migrations (version) VALUES ('20130815173041');

INSERT INTO schema_migrations (version) VALUES ('20130820015528');

INSERT INTO schema_migrations (version) VALUES ('20130901170747');

INSERT INTO schema_migrations (version) VALUES ('20130905145009');

INSERT INTO schema_migrations (version) VALUES ('20130905145241');

INSERT INTO schema_migrations (version) VALUES ('20131203145334');

INSERT INTO schema_migrations (version) VALUES ('20140415172844');

INSERT INTO schema_migrations (version) VALUES ('20140415173508');

INSERT INTO schema_migrations (version) VALUES ('20140429002904');

INSERT INTO schema_migrations (version) VALUES ('20140513155451');

INSERT INTO schema_migrations (version) VALUES ('20140526225628');

INSERT INTO schema_migrations (version) VALUES ('20140624165038');

INSERT INTO schema_migrations (version) VALUES ('20140718155905');

INSERT INTO schema_migrations (version) VALUES ('20140803222351');

INSERT INTO schema_migrations (version) VALUES ('20140803224445');

INSERT INTO schema_migrations (version) VALUES ('20140816164036');

INSERT INTO schema_migrations (version) VALUES ('20140908044535');

INSERT INTO schema_migrations (version) VALUES ('20140908045403');

INSERT INTO schema_migrations (version) VALUES ('20140908045735');

INSERT INTO schema_migrations (version) VALUES ('20140909151338');

INSERT INTO schema_migrations (version) VALUES ('20140912060222');

INSERT INTO schema_migrations (version) VALUES ('20140912062536');

INSERT INTO schema_migrations (version) VALUES ('20150811052343');

INSERT INTO schema_migrations (version) VALUES ('20160617045028');

INSERT INTO schema_migrations (version) VALUES ('20160619043445');

INSERT INTO schema_migrations (version) VALUES ('20160627234846');

INSERT INTO schema_migrations (version) VALUES ('20160628040744');

INSERT INTO schema_migrations (version) VALUES ('20160710013925');

INSERT INTO schema_migrations (version) VALUES ('20160719182417');

INSERT INTO schema_migrations (version) VALUES ('20160719182706');

