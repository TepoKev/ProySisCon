PGDMP                     	    v           proy-siscon-db    10.5    10.5 /               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false                       1262    16866    proy-siscon-db    DATABASE     �   CREATE DATABASE "proy-siscon-db" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_El Salvador.1252' LC_CTYPE = 'Spanish_El Salvador.1252';
     DROP DATABASE "proy-siscon-db";
             postgres    false                       0    0    DATABASE "proy-siscon-db"    COMMENT     d   COMMENT ON DATABASE "proy-siscon-db" IS 'Base de datos usada en el proyecto de sistemas contables';
                  postgres    false    2845                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false                        0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    16867    cargos_abonos    TABLE     �   CREATE TABLE public.cargos_abonos (
    id integer NOT NULL,
    monto real,
    operacion character varying(1),
    id_cuenta integer,
    id_partida integer
);
 !   DROP TABLE public.cargos_abonos;
       public         postgres    false    3            �            1259    16870    cargos_abonos_id_seq    SEQUENCE     }   CREATE SEQUENCE public.cargos_abonos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.cargos_abonos_id_seq;
       public       postgres    false    3    196            !           0    0    cargos_abonos_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.cargos_abonos_id_seq OWNED BY public.cargos_abonos.id;
            public       postgres    false    197            �            1259    16872    cuentas    TABLE     �   CREATE TABLE public.cuentas (
    id integer NOT NULL,
    codigo character varying(20),
    nombre character varying(100),
    descripcion character varying(150),
    id_superior integer,
    tipo character varying(1),
    saldo real
);
    DROP TABLE public.cuentas;
       public         postgres    false    3            �            1259    16875    cuentas_id_seq    SEQUENCE     w   CREATE SEQUENCE public.cuentas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.cuentas_id_seq;
       public       postgres    false    3    198            "           0    0    cuentas_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.cuentas_id_seq OWNED BY public.cuentas.id;
            public       postgres    false    199            �            1259    16877 	   parciales    TABLE     �   CREATE TABLE public.parciales (
    id integer NOT NULL,
    monto real,
    id_cuenta integer,
    id_cargos_abonos integer
);
    DROP TABLE public.parciales;
       public         postgres    false    3            �            1259    16880    parciales_id_seq    SEQUENCE     y   CREATE SEQUENCE public.parciales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.parciales_id_seq;
       public       postgres    false    200    3            #           0    0    parciales_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.parciales_id_seq OWNED BY public.parciales.id;
            public       postgres    false    201            �            1259    16882    partidas    TABLE     �   CREATE TABLE public.partidas (
    id integer NOT NULL,
    fecha date,
    descripcion character varying(150),
    contador integer NOT NULL
);
    DROP TABLE public.partidas;
       public         postgres    false    3            �            1259    16885    partidas_contador_seq    SEQUENCE     ~   CREATE SEQUENCE public.partidas_contador_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.partidas_contador_seq;
       public       postgres    false    202    3            $           0    0    partidas_contador_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.partidas_contador_seq OWNED BY public.partidas.contador;
            public       postgres    false    203            �            1259    16887    partidas_id_seq    SEQUENCE     x   CREATE SEQUENCE public.partidas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.partidas_id_seq;
       public       postgres    false    3    202            %           0    0    partidas_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.partidas_id_seq OWNED BY public.partidas.id;
            public       postgres    false    204            �
           2604    16889    cargos_abonos id    DEFAULT     t   ALTER TABLE ONLY public.cargos_abonos ALTER COLUMN id SET DEFAULT nextval('public.cargos_abonos_id_seq'::regclass);
 ?   ALTER TABLE public.cargos_abonos ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    197    196            �
           2604    16890 
   cuentas id    DEFAULT     h   ALTER TABLE ONLY public.cuentas ALTER COLUMN id SET DEFAULT nextval('public.cuentas_id_seq'::regclass);
 9   ALTER TABLE public.cuentas ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    199    198            �
           2604    16891    parciales id    DEFAULT     l   ALTER TABLE ONLY public.parciales ALTER COLUMN id SET DEFAULT nextval('public.parciales_id_seq'::regclass);
 ;   ALTER TABLE public.parciales ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    201    200            �
           2604    16892    partidas id    DEFAULT     j   ALTER TABLE ONLY public.partidas ALTER COLUMN id SET DEFAULT nextval('public.partidas_id_seq'::regclass);
 :   ALTER TABLE public.partidas ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    204    202            �
           2604    16893    partidas contador    DEFAULT     v   ALTER TABLE ONLY public.partidas ALTER COLUMN contador SET DEFAULT nextval('public.partidas_contador_seq'::regclass);
 @   ALTER TABLE public.partidas ALTER COLUMN contador DROP DEFAULT;
       public       postgres    false    203    202                      0    16867    cargos_abonos 
   TABLE DATA               T   COPY public.cargos_abonos (id, monto, operacion, id_cuenta, id_partida) FROM stdin;
    public       postgres    false    196   V2                 0    16872    cuentas 
   TABLE DATA               \   COPY public.cuentas (id, codigo, nombre, descripcion, id_superior, tipo, saldo) FROM stdin;
    public       postgres    false    198   �3                 0    16877 	   parciales 
   TABLE DATA               K   COPY public.parciales (id, monto, id_cuenta, id_cargos_abonos) FROM stdin;
    public       postgres    false    200   x?                 0    16882    partidas 
   TABLE DATA               D   COPY public.partidas (id, fecha, descripcion, contador) FROM stdin;
    public       postgres    false    202   �?       &           0    0    cargos_abonos_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.cargos_abonos_id_seq', 1, false);
            public       postgres    false    197            '           0    0    cuentas_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.cuentas_id_seq', 1, true);
            public       postgres    false    199            (           0    0    parciales_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.parciales_id_seq', 1, false);
            public       postgres    false    201            )           0    0    partidas_contador_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.partidas_contador_seq', 22, true);
            public       postgres    false    203            *           0    0    partidas_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.partidas_id_seq', 1, false);
            public       postgres    false    204            �
           2606    16895     cargos_abonos cargos_abonos_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.cargos_abonos
    ADD CONSTRAINT cargos_abonos_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.cargos_abonos DROP CONSTRAINT cargos_abonos_pkey;
       public         postgres    false    196            �
           2606    16897    cuentas cuentas_codigo_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_codigo_key UNIQUE (codigo);
 D   ALTER TABLE ONLY public.cuentas DROP CONSTRAINT cuentas_codigo_key;
       public         postgres    false    198            �
           2606    16899    cuentas cuentas_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.cuentas DROP CONSTRAINT cuentas_pkey;
       public         postgres    false    198            �
           2606    16901    parciales parciales_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.parciales
    ADD CONSTRAINT parciales_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.parciales DROP CONSTRAINT parciales_pkey;
       public         postgres    false    200            �
           2606    16903    partidas partidas_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.partidas
    ADD CONSTRAINT partidas_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.partidas DROP CONSTRAINT partidas_pkey;
       public         postgres    false    202            �
           2606    16904 *   cargos_abonos cargos_abonos_id_cuenta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cargos_abonos
    ADD CONSTRAINT cargos_abonos_id_cuenta_fkey FOREIGN KEY (id_cuenta) REFERENCES public.cuentas(id);
 T   ALTER TABLE ONLY public.cargos_abonos DROP CONSTRAINT cargos_abonos_id_cuenta_fkey;
       public       postgres    false    2700    198    196            �
           2606    16909 +   cargos_abonos cargos_abonos_id_partida_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cargos_abonos
    ADD CONSTRAINT cargos_abonos_id_partida_fkey FOREIGN KEY (id_partida) REFERENCES public.partidas(id);
 U   ALTER TABLE ONLY public.cargos_abonos DROP CONSTRAINT cargos_abonos_id_partida_fkey;
       public       postgres    false    2704    196    202            �
           2606    16914     cuentas cuentas_id_superior_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_id_superior_fkey FOREIGN KEY (id_superior) REFERENCES public.cuentas(id);
 J   ALTER TABLE ONLY public.cuentas DROP CONSTRAINT cuentas_id_superior_fkey;
       public       postgres    false    2700    198    198            �
           2606    16919 )   parciales parciales_id_cargos_abonos_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.parciales
    ADD CONSTRAINT parciales_id_cargos_abonos_fkey FOREIGN KEY (id_cargos_abonos) REFERENCES public.cargos_abonos(id);
 S   ALTER TABLE ONLY public.parciales DROP CONSTRAINT parciales_id_cargos_abonos_fkey;
       public       postgres    false    200    2696    196            �
           2606    16924 "   parciales parciales_id_cuenta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.parciales
    ADD CONSTRAINT parciales_id_cuenta_fkey FOREIGN KEY (id_cuenta) REFERENCES public.cuentas(id);
 L   ALTER TABLE ONLY public.parciales DROP CONSTRAINT parciales_id_cuenta_fkey;
       public       postgres    false    2700    200    198               -  x�M�K�!D��a:��]f31���`U+����P�l�s6�#�N���1�s���Ɍ:3�/E�F������%�5��n�)�,a%��C���9v%?�����@.��&��V��j�~*W�����~��#�rK�^i�`�K�+N��3Z�[��R
�=��a��լ7Z�A��s�d�&���@cj{B����6��/�w���%��_���8����d=J�\{��:�I����q�ss���Y��
�ͳ���Ώ�v����9s���]��������v����� �h��H         �  x��YI��F]�N�ew�D&.� >H� ɰ���Zx�]_�_�3���`蘭�Y/�.
�g{���|��T��տ����T��F��|�]�����RپPSw���y��p�q�7�x���<�䜦s��s�A��{�{iz��.�Gw�Y��mn�c�u�]��f���녏W�x�U���?���4u�Dj�Qe�C��om;N�t�Q��	������Ԓ���氭���l�Q�.��D{2��Dã�f���j�[7��4���M���2ߦ���O����1U��L�� xW]o���N��3��П�F�[?�:������y�Ǒ\�С���;u�n��R�Ri�ol���u$��b����}�ZS{�N�h?n����v���s���u��#*�3L��"�K��N>~�!wi"���ϚْCF�3e�k���xw9�i���m�i�|1�w�yw'';E�����[F�ﮖ.���9q:��B�c���R-�*�0س=���������'Ϋ�u"#�YX��ס�����'vO�9�gV{��DJ� >@�UP�Z�W���7Z�9��	CY�`
e�vR�|�q���MMO&�-.�D&.3�:C���N��@�����������3��af��/o��Fz���{�Sp�O�_Z
�ݙ�L�zb�88T�VW{C>~ڝ-���2j�Ε� 4,,�e���]�H��˩G\��r�2��H8��Bݸ�^���7� 9���Ή,�Cf$�`Q�@ E�0�fNE�-�R0q�o��\�9���tqP>�
w��Ev��+K|bAhP��Z/T'a�h W�{�a�{���`��5�nL���{�\��B��c?��1=�#��TFeAԮ��IsF��4�m�P�s��jO�Ԭʶ�~��	6�r�6v0���|lk�0� �^���a��mO;P�h�+/���u�.k�p��c�VB���L�_�މ���#��X��ӿ�m��Ķa#��L�-ޒ|�z�!w����u:@	��J� � ʷ�!��q�x�#"��)�ݍM�U\�7z���/DE$W�H%!Bw���c�#&���k+��=_�2 ���A�W��0	��E��Z�Y���H��Ѐ��5#tD��f�о�.o��������nz����$��	w?���Tt�l�)ye� )��#! t���Q:������<q����!�;-�@�6��@��r�	ҝ=�����P�ް�-9�rCэF� �ȍ֗��o2�t��i�C�ƻω.�4ZѠ�E䭟�d01\�i�b<�������Ҷ�oT��=��p�\>Clȇ��Q��]ˬ�L!�RZME��г�c�E��<�g��q&����8�$#LFV��7uv����xmi���G���E*6t��E�
0��Zw9��ҸM?��?fʉ��J��C����]d}J�l�ڵ-���*����~1��ꌲo��+���"!5�)��.�d�����U��8�'K�GZ�����ϫe���o�Y�i���� =���7��LW�*X��5k��J� <S�`0�� ��M����z�tx�sF��>��̾��u����Pۄ�K�%�4��SRg�X�X���-��O/\����A2���cZN"�=LS�"�)�}�ni��>�����=�7��|㹚��$d]'��Kstc���S��F��7��D.Al�WC��Y&�v���c���|����w�eg����}�%�"��K%9g��Ւi��1+GP�A���I��Z{>r����b���RL'���i�@����S��0Ũ�xS��������c�����O�v��Z:46W��'(6��2����f��D
���x^��r^��_'�o��qB�&'s>Y�b��y8^K��S�׎���h��S�5.�6���H�6��)ԗ�`�M�����������W֜����e�ǜ���x>L�j������w� ���� ��tA A[���m�[�i�;�m$�D2����NG�-&��h9��q��(�I���u�V����1���He7�gg��:S���a:g��:~,Z+0��`�o�O�;�ԥ�~M^��%L�3P�8޿.tU����󂄚��d�����>AӖ�J�=�������h7:DA	�I��(� ��G���o"�!/�N�����2���n(� T<R؅$����>�>H"FsP�.~�]�޿44P7Ke��.o��[/��i���K_��Z/��l����o��L������X�!.�A���聫t�R�~�u���rp&�P�=���D5\N[��N���~r8��p�����%�\N{��e��Az�
�Ӛ|暴�����2�����[�d�9v�T������K��v�UT�lj�����I��@����"V+x�6��"������N�����z�u�����;��}�9�M�A>��G��;9�~H��Rq^����#��'@=��q��el�����1�`e ��ߌRMBPJ�!��ZV?9-��k�	��	X�RϿ�R=]���]���d�=�t*�?tT�0���ڥ*�#���E�	�,�q�?X�j��݀��h�|��9h�������S�\,�Q��%�Ǖc�iL��R�i���C�Kӂ��Җ������ͪՀ*y�n��e3�
���Wy��u���"�
�2���u�x`f,�����/!]��(� O�f���f m3H�=$m3b2`^��D��\ی�N�l����6#l�@یG����6���'�f<g�Ŷ������_��(�˿�6#NO�f����i��~�mF(���6#�\��(���m3��o�͈��m������6��o�͈�iی2��(�������f<�cی��m3��mU9ܑ�M/���UK�8P�n�QZ�-1���VK�иn�Q2�Zb��UK�]4l��Bh~�%F(���%F ��ZC#Ć5�~���[���            x������ � �         �   x���1n�0Eg��@QN�d�:v�BK�j��)�z�^��hx7��Q����?�z\8&�iF�-�� #)rH���E�:�1\��g��4��))��0Ny2�q���r�^��c`Rg_2������m��F�6rm#�6ri#d)�`R�!�Rl��"�e�8ܬb=�;O<{�q������m4���SkȂs���G�}t�G�������|1|EC�� ��!��     