CREATE TABLE public.affixes (
    id integer NOT NULL,
    type text,
    salish text,
    nicodemus text,
    english text,
    link text,
    page text,
    editnote text,
    active text,
    "prevId" integer,
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.affixes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.affixes_id_seq OWNED BY public.affixes.id;
CREATE TABLE public.audiofiles (
    id integer NOT NULL,
    subdir text,
    src text,
    type text,
    direct text,
    active text,
    "audiosetId" integer,
    "prevId" integer,
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.audiofiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.audiofiles_id_seq OWNED BY public.audiofiles.id;
CREATE TABLE public.audiosetmetadata (
    id integer NOT NULL,
    "audioSetId" integer,
    metadata text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.audiosetmetadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.audiosetmetadata_id_seq OWNED BY public.audiosetmetadata.id;
CREATE TABLE public.audiosets (
    id integer NOT NULL,
    title text,
    speaker text,
    active text,
    "textId" integer,
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.audiosets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.audiosets_id_seq OWNED BY public.audiosets.id;
CREATE TABLE public.bibliographies (
    id integer NOT NULL,
    author text,
    year text,
    title text,
    reference text,
    link text,
    linktext text,
    active text,
    "prevId" integer,
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.bibliographies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.bibliographies_id_seq OWNED BY public.bibliographies.id;
CREATE TABLE public.consonants (
    id integer NOT NULL,
    orthography text,
    voice text,
    manner text,
    secondary text,
    labial text,
    alveolar text,
    alveopalatal text,
    "lateral" text,
    palatal text,
    velar text,
    uvular text,
    glottal text,
    pharyngeal text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.consonants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.consonants_id_seq OWNED BY public.consonants.id;
CREATE TABLE public.elicitationfiles (
    id integer NOT NULL,
    src text,
    type text,
    direct text,
    "elicitationSetId" integer,
    active text,
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.elicitationfiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.elicitationfiles_id_seq OWNED BY public.elicitationfiles.id;
CREATE TABLE public.elicitationsets (
    id integer NOT NULL,
    title text,
    language text,
    speaker text,
    transcription text,
    editnote text,
    active text,
    "userId" integer,
    "prevID" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.elicitationsets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.elicitationsets_id_seq OWNED BY public.elicitationsets.id;
CREATE TABLE public.roles (
    id integer NOT NULL,
    role_code text,
    role_value text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
CREATE TABLE public.roots (
    id integer NOT NULL,
    root text,
    number integer,
    sense text,
    salish text,
    nicodemus text,
    symbol text,
    english text,
    grammar text,
    crossref text,
    variant text,
    cognate text,
    editnote text,
    active text,
    "prevId" integer,
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.roots_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.roots_id_seq OWNED BY public.roots.id;
CREATE TABLE public.spellings (
    id integer NOT NULL,
    reichard text,
    nicodemus text,
    salish text,
    english text,
    note text,
    active text,
    "prevId" integer,
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.spellings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.spellings_id_seq OWNED BY public.spellings.id;
CREATE TABLE public.stems (
    id integer NOT NULL,
    category text,
    reichard text,
    doak text,
    salish text,
    nicodemus text,
    english text,
    note text,
    editnote text,
    active text,
    "prevId" integer,
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.stems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.stems_id_seq OWNED BY public.stems.id;
CREATE TABLE public.textfilemetadata (
    id integer NOT NULL,
    "textFileId" integer,
    metadata text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.textfilemetadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.textfilemetadata_id_seq OWNED BY public.textfilemetadata.id;
CREATE TABLE public.textfiles (
    id integer NOT NULL,
    subdir text,
    src text,
    "resType" text,
    "msType" text,
    "fileType" text,
    "textId" integer,
    active text,
    "prevId" integer,
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.textfiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.textfiles_id_seq OWNED BY public.textfiles.id;
CREATE TABLE public.textimages (
    id integer NOT NULL,
    subdir text,
    src text,
    "textFileId" integer,
    active text,
    "prevId" integer,
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.textimages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.textimages_id_seq OWNED BY public.textimages.id;
CREATE TABLE public.texts (
    id integer NOT NULL,
    title text,
    speaker text,
    cycle text,
    rnumber text,
    tnumber text,
    active text,
    "prevId" integer,
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.texts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.texts_id_seq OWNED BY public.texts.id;
CREATE TABLE public.users (
    id integer NOT NULL,
    first text,
    last text,
    username text,
    email text,
    password text,
    roles text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
CREATE TABLE public.vowels (
    id integer NOT NULL,
    orthography text,
    height text,
    front text,
    central text,
    back text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.vowels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.vowels_id_seq OWNED BY public.vowels.id;
ALTER TABLE ONLY public.affixes ALTER COLUMN id SET DEFAULT nextval('public.affixes_id_seq'::regclass);
ALTER TABLE ONLY public.audiofiles ALTER COLUMN id SET DEFAULT nextval('public.audiofiles_id_seq'::regclass);
ALTER TABLE ONLY public.audiosetmetadata ALTER COLUMN id SET DEFAULT nextval('public.audiosetmetadata_id_seq'::regclass);
ALTER TABLE ONLY public.audiosets ALTER COLUMN id SET DEFAULT nextval('public.audiosets_id_seq'::regclass);
ALTER TABLE ONLY public.bibliographies ALTER COLUMN id SET DEFAULT nextval('public.bibliographies_id_seq'::regclass);
ALTER TABLE ONLY public.consonants ALTER COLUMN id SET DEFAULT nextval('public.consonants_id_seq'::regclass);
ALTER TABLE ONLY public.elicitationfiles ALTER COLUMN id SET DEFAULT nextval('public.elicitationfiles_id_seq'::regclass);
ALTER TABLE ONLY public.elicitationsets ALTER COLUMN id SET DEFAULT nextval('public.elicitationsets_id_seq'::regclass);
ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
ALTER TABLE ONLY public.roots ALTER COLUMN id SET DEFAULT nextval('public.roots_id_seq'::regclass);
ALTER TABLE ONLY public.spellings ALTER COLUMN id SET DEFAULT nextval('public.spellings_id_seq'::regclass);
ALTER TABLE ONLY public.stems ALTER COLUMN id SET DEFAULT nextval('public.stems_id_seq'::regclass);
ALTER TABLE ONLY public.textfilemetadata ALTER COLUMN id SET DEFAULT nextval('public.textfilemetadata_id_seq'::regclass);
ALTER TABLE ONLY public.textfiles ALTER COLUMN id SET DEFAULT nextval('public.textfiles_id_seq'::regclass);
ALTER TABLE ONLY public.textimages ALTER COLUMN id SET DEFAULT nextval('public.textimages_id_seq'::regclass);
ALTER TABLE ONLY public.texts ALTER COLUMN id SET DEFAULT nextval('public.texts_id_seq'::regclass);
ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
ALTER TABLE ONLY public.vowels ALTER COLUMN id SET DEFAULT nextval('public.vowels_id_seq'::regclass);
ALTER TABLE ONLY public.affixes
    ADD CONSTRAINT affixes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.audiofiles
    ADD CONSTRAINT audiofiles_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.audiosetmetadata
    ADD CONSTRAINT audiosetmetadata_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.audiosets
    ADD CONSTRAINT audiosets_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.bibliographies
    ADD CONSTRAINT bibliographies_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.consonants
    ADD CONSTRAINT consonants_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.elicitationfiles
    ADD CONSTRAINT elicitationfiles_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.elicitationsets
    ADD CONSTRAINT elicitationsets_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_code_key UNIQUE (role_code);
ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_value_key UNIQUE (role_value);
ALTER TABLE ONLY public.roots
    ADD CONSTRAINT roots_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.spellings
    ADD CONSTRAINT spellings_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.stems
    ADD CONSTRAINT stems_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.textfilemetadata
    ADD CONSTRAINT textfilemetadata_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.textfiles
    ADD CONSTRAINT textfiles_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.textimages
    ADD CONSTRAINT textimages_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.texts
    ADD CONSTRAINT texts_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.vowels
    ADD CONSTRAINT vowels_pkey PRIMARY KEY (id);
