CREATE TABLE public.users (
    id integer NOT NULL,
    first text,
    last text,
    username text,
    email text,
    password text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE TABLE public.audiofiles (
    id integer NOT NULL,
    subdir text,
    src text,
    type text,
    direct text,
    "audiosetId" integer,
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE FUNCTION public.audio_with_path(audiofiles_row public.audiofiles) RETURNS text
    LANGUAGE sql STABLE
    AS $$
  SELECT 'http://localhost:3500/texts/' || audiofiles_row.subdir || '/' || audiofiles_row.src
$$;
CREATE TABLE public.elicitationfiles (
    id integer NOT NULL,
    src text,
    type text,
    direct text,
    "elicitationSetId" integer,
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE FUNCTION public.elicitationfiles_with_path(elicitationfiles_row public.elicitationfiles) RETURNS text
    LANGUAGE sql STABLE
    AS $$
  SELECT 'http://localhost:3500/elicitations/' || elicitationfiles_row.src
$$;
CREATE FUNCTION public.fetch_audit_usernames(audit_row audit.logged_actions) RETURNS SETOF public.users
    LANGUAGE sql STABLE
    AS $$
  SELECT *
  FROM users u
  WHERE
    to_jsonb(u.id) = audit_row.hasura_user -> "id";
$$;
CREATE TABLE public.text_result (
    result text
);
CREATE FUNCTION public.get_session_role(hasura_session json) RETURNS SETOF public.text_result
    LANGUAGE sql STABLE
    AS $$
    SELECT q.* FROM (VALUES (hasura_session ->> 'x-hasura-role')) q
$$;
CREATE TABLE public.session_table (
    unused text NOT NULL
);
CREATE FUNCTION public.get_session_vars(session_table_row public.session_table, hasura_session json) RETURNS SETOF public.session_table
    LANGUAGE sql STABLE
    AS $$
SELECT hasura_session ->> 'x-hasura-user-id';
$$;
CREATE FUNCTION public.jsonb_minus(json jsonb, keys text[]) RETURNS jsonb
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  SELECT
    -- Only executes opration if the JSON document has the keys
    CASE WHEN "json" ?| "keys"
      THEN COALESCE(
          (SELECT ('{' || string_agg(to_json("key")::text || ':' || "value", ',') || '}')
           FROM jsonb_each("json")
           WHERE "key" <> ALL ("keys")),
          '{}'
        )::jsonb
      ELSE "json"
    END
$$;
CREATE FUNCTION public.jsonb_minus(arg1 jsonb, arg2 jsonb) RETURNS jsonb
    LANGUAGE sql
    AS $$
  SELECT
    COALESCE(
      json_object_agg(
        key,
        CASE
          -- if the value is an object and the value of the second argument is
          -- not null, we do a recursion
          WHEN jsonb_typeof(value) = 'object' AND arg2 -> key IS NOT NULL
          THEN jsonb_minus(value, arg2 -> key)
          -- for all the other types, we just return the value
          ELSE value
        END
      ),
    '{}'
    )::jsonb
  FROM
    jsonb_each(arg1)
  WHERE
    arg1 -> key <> arg2 -> key
    OR arg2 -> key IS NULL
$$;
CREATE TABLE public.textfiles (
    id integer NOT NULL,
    subdir text,
    src text,
    "resType" text,
    "msType" text,
    "fileType" text,
    "textId" integer,
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE FUNCTION public.textfile_with_path(textfiles_row public.textfiles) RETURNS text
    LANGUAGE sql STABLE
    AS $$
  SELECT 'http://localhost:3500/texts/' || textfiles_row.subdir || '/' || textfiles_row.src
$$;
CREATE TABLE public.textimages (
    id integer NOT NULL,
    subdir text,
    src text,
    "textFileId" integer,
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE FUNCTION public.textimage_with_path(textimages_row public.textimages) RETURNS text
    LANGUAGE sql STABLE
    AS $$
  SELECT 'http://localhost:3500/texts/' || textimages_row.subdir || '/' || textimages_row.src
$$;
CREATE OPERATOR public.- (
    FUNCTION = public.jsonb_minus,
    LEFTARG = jsonb,
    RIGHTARG = text[]
);
CREATE OPERATOR public.- (
    FUNCTION = public.jsonb_minus,
    LEFTARG = jsonb,
    RIGHTARG = jsonb
);
CREATE TABLE public.affix_types (
    id integer NOT NULL,
    value text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.affix_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.affix_types_id_seq OWNED BY public.affix_types.id;
CREATE TABLE public.affixes (
    id integer NOT NULL,
    type integer,
    salish text,
    nicodemus text,
    english text,
    link text,
    page text,
    editnote text,
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
    "userId" integer,
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
CREATE TABLE public.stem_categories (
    id integer NOT NULL,
    value text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.stem_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.stem_categories_id_seq OWNED BY public.stem_categories.id;
CREATE TABLE public.stems (
    id integer NOT NULL,
    category integer,
    reichard text,
    doak text,
    salish text,
    nicodemus text,
    english text,
    note text,
    editnote text,
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
CREATE SEQUENCE public.textfiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.textfiles_id_seq OWNED BY public.textfiles.id;
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
CREATE TABLE public.user_roles (
    "userId" integer NOT NULL,
    "roleId" integer NOT NULL,
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
ALTER TABLE ONLY public.affix_types ALTER COLUMN id SET DEFAULT nextval('public.affix_types_id_seq'::regclass);
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
ALTER TABLE ONLY public.stem_categories ALTER COLUMN id SET DEFAULT nextval('public.stem_categories_id_seq'::regclass);
ALTER TABLE ONLY public.stems ALTER COLUMN id SET DEFAULT nextval('public.stems_id_seq'::regclass);
ALTER TABLE ONLY public.textfilemetadata ALTER COLUMN id SET DEFAULT nextval('public.textfilemetadata_id_seq'::regclass);
ALTER TABLE ONLY public.textfiles ALTER COLUMN id SET DEFAULT nextval('public.textfiles_id_seq'::regclass);
ALTER TABLE ONLY public.textimages ALTER COLUMN id SET DEFAULT nextval('public.textimages_id_seq'::regclass);
ALTER TABLE ONLY public.texts ALTER COLUMN id SET DEFAULT nextval('public.texts_id_seq'::regclass);
ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
ALTER TABLE ONLY public.vowels ALTER COLUMN id SET DEFAULT nextval('public.vowels_id_seq'::regclass);
ALTER TABLE ONLY public.affix_types
    ADD CONSTRAINT affix_types_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.affix_types
    ADD CONSTRAINT affix_types_value_key UNIQUE (value);
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
ALTER TABLE ONLY public.session_table
    ADD CONSTRAINT session_table_pkey PRIMARY KEY (unused);
ALTER TABLE ONLY public.spellings
    ADD CONSTRAINT spellings_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.stem_categories
    ADD CONSTRAINT stem_categories_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.stem_categories
    ADD CONSTRAINT stem_categories_value_key UNIQUE (value);
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
ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY ("userId", "roleId");
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.vowels
    ADD CONSTRAINT vowels_pkey PRIMARY KEY (id);
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.affix_types FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.affixes FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.audiofiles FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.audiosetmetadata FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.audiosets FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.bibliographies FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.consonants FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.elicitationfiles FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.elicitationsets FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.roles FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.roots FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.spellings FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.stem_categories FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.stems FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.textfilemetadata FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.textfiles FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.textimages FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.texts FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.user_roles FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_row AFTER INSERT OR DELETE OR UPDATE ON public.vowels FOR EACH ROW EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.affix_types FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.affixes FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.audiofiles FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.audiosetmetadata FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.audiosets FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.bibliographies FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.consonants FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.elicitationfiles FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.elicitationsets FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.roles FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.roots FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.spellings FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.stem_categories FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.stems FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.textfilemetadata FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.textfiles FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.textimages FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.texts FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.user_roles FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.users FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
CREATE TRIGGER audit_trigger_stm AFTER TRUNCATE ON public.vowels FOR EACH STATEMENT EXECUTE FUNCTION audit.if_modified_func('true');
ALTER TABLE ONLY public.affixes
    ADD CONSTRAINT affixes_type_fkey FOREIGN KEY (type) REFERENCES public.affix_types(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.affixes
    ADD CONSTRAINT "affixes_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.audiofiles
    ADD CONSTRAINT "audiofiles_audiosetId_fkey" FOREIGN KEY ("audiosetId") REFERENCES public.audiosets(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.audiofiles
    ADD CONSTRAINT "audiofiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.audiosetmetadata
    ADD CONSTRAINT "audiosetmetadata_audioSetId_fkey" FOREIGN KEY ("audioSetId") REFERENCES public.audiosets(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.audiosets
    ADD CONSTRAINT "audiosets_textId_fkey" FOREIGN KEY ("textId") REFERENCES public.texts(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.audiosets
    ADD CONSTRAINT "audiosets_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.elicitationfiles
    ADD CONSTRAINT "elicitationfiles_elicitationSetId_fkey" FOREIGN KEY ("elicitationSetId") REFERENCES public.elicitationsets(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.elicitationfiles
    ADD CONSTRAINT "elicitationfiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.elicitationsets
    ADD CONSTRAINT "elicitationsets_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.roots
    ADD CONSTRAINT "roots_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.spellings
    ADD CONSTRAINT "spellings_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.stems
    ADD CONSTRAINT stems_category_fkey FOREIGN KEY (category) REFERENCES public.stem_categories(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.stems
    ADD CONSTRAINT "stems_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.textfilemetadata
    ADD CONSTRAINT "textfilemetadata_textFileId_fkey" FOREIGN KEY ("textFileId") REFERENCES public.textfiles(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.textfiles
    ADD CONSTRAINT "textfiles_textId_fkey" FOREIGN KEY ("textId") REFERENCES public.texts(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.textfiles
    ADD CONSTRAINT "textfiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.textimages
    ADD CONSTRAINT "textimages_textFileId_fkey" FOREIGN KEY ("textFileId") REFERENCES public.textfiles(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.textimages
    ADD CONSTRAINT "textimages_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.texts
    ADD CONSTRAINT "texts_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT "user_roles_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT "user_roles_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
