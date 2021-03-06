PGDMP     #                     w            proy-siscon-db    9.6.11    11.1 (Debian 11.1-1.pgdg90+1) 1    �
           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �
           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �
           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �
           1262    44578    proy-siscon-db    DATABASE     �   CREATE DATABASE "proy-siscon-db" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'es_SV.UTF-8' LC_CTYPE = 'es_SV.UTF-8';
     DROP DATABASE "proy-siscon-db";
             postgres    false            �            1259    44579    cargos_abonos    TABLE     �   CREATE TABLE public.cargos_abonos (
    id integer NOT NULL,
    monto real,
    operacion character varying(1),
    id_cuenta integer,
    id_partida integer
);
 !   DROP TABLE public.cargos_abonos;
       public         postgres    false            �            1259    44582    cargos_abonos_id_seq    SEQUENCE     }   CREATE SEQUENCE public.cargos_abonos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.cargos_abonos_id_seq;
       public       postgres    false    185            �
           0    0    cargos_abonos_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.cargos_abonos_id_seq OWNED BY public.cargos_abonos.id;
            public       postgres    false    186            �            1259    44584    cuentas    TABLE     �   CREATE TABLE public.cuentas (
    id integer NOT NULL,
    codigo character varying(20),
    nombre character varying(100),
    descripcion character varying(150),
    id_superior integer,
    tipo character varying(1),
    saldo real
);
    DROP TABLE public.cuentas;
       public         postgres    false            �            1259    44587    cuentas_id_seq    SEQUENCE     w   CREATE SEQUENCE public.cuentas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.cuentas_id_seq;
       public       postgres    false    187            �
           0    0    cuentas_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.cuentas_id_seq OWNED BY public.cuentas.id;
            public       postgres    false    188            �            1259    44589 	   parametro    TABLE     �   CREATE TABLE public.parametro (
    id integer NOT NULL,
    nombre character varying(35),
    valor character varying(100),
    id_periodo integer
);
    DROP TABLE public.parametro;
       public         postgres    false            �            1259    44592    partidas    TABLE     �   CREATE TABLE public.partidas (
    id integer NOT NULL,
    fecha date,
    descripcion character varying(150),
    contador integer NOT NULL,
    id_periodo integer
);
    DROP TABLE public.partidas;
       public         postgres    false            �            1259    44595    partidas_contador_seq    SEQUENCE     ~   CREATE SEQUENCE public.partidas_contador_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.partidas_contador_seq;
       public       postgres    false    190            �
           0    0    partidas_contador_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.partidas_contador_seq OWNED BY public.partidas.contador;
            public       postgres    false    191            �            1259    44597    partidas_id_seq    SEQUENCE     x   CREATE SEQUENCE public.partidas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.partidas_id_seq;
       public       postgres    false    190            �
           0    0    partidas_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.partidas_id_seq OWNED BY public.partidas.id;
            public       postgres    false    192            �            1259    44599    periodo    TABLE     �   CREATE TABLE public.periodo (
    id integer NOT NULL,
    fecha_inicial date,
    fecha_final date,
    finalizado boolean,
    encurso boolean
);
    DROP TABLE public.periodo;
       public         postgres    false            �            1259    44602    periodo_id_seq    SEQUENCE     w   CREATE SEQUENCE public.periodo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.periodo_id_seq;
       public       postgres    false    189                        0    0    periodo_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.periodo_id_seq OWNED BY public.parametro.id;
            public       postgres    false    194            �            1259    44604    periodo_id_seq1    SEQUENCE     x   CREATE SEQUENCE public.periodo_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.periodo_id_seq1;
       public       postgres    false    193                       0    0    periodo_id_seq1    SEQUENCE OWNED BY     B   ALTER SEQUENCE public.periodo_id_seq1 OWNED BY public.periodo.id;
            public       postgres    false    195            _
           2604    44606    cargos_abonos id    DEFAULT     t   ALTER TABLE ONLY public.cargos_abonos ALTER COLUMN id SET DEFAULT nextval('public.cargos_abonos_id_seq'::regclass);
 ?   ALTER TABLE public.cargos_abonos ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    186    185            `
           2604    44607 
   cuentas id    DEFAULT     h   ALTER TABLE ONLY public.cuentas ALTER COLUMN id SET DEFAULT nextval('public.cuentas_id_seq'::regclass);
 9   ALTER TABLE public.cuentas ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    188    187            a
           2604    44608    parametro id    DEFAULT     j   ALTER TABLE ONLY public.parametro ALTER COLUMN id SET DEFAULT nextval('public.periodo_id_seq'::regclass);
 ;   ALTER TABLE public.parametro ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    194    189            b
           2604    44609    partidas id    DEFAULT     j   ALTER TABLE ONLY public.partidas ALTER COLUMN id SET DEFAULT nextval('public.partidas_id_seq'::regclass);
 :   ALTER TABLE public.partidas ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    192    190            c
           2604    44610    partidas contador    DEFAULT     v   ALTER TABLE ONLY public.partidas ALTER COLUMN contador SET DEFAULT nextval('public.partidas_contador_seq'::regclass);
 @   ALTER TABLE public.partidas ALTER COLUMN contador DROP DEFAULT;
       public       postgres    false    191    190            d
           2604    44611 
   periodo id    DEFAULT     i   ALTER TABLE ONLY public.periodo ALTER COLUMN id SET DEFAULT nextval('public.periodo_id_seq1'::regclass);
 9   ALTER TABLE public.periodo ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    195    193            �
          0    44579    cargos_abonos 
   TABLE DATA               T   COPY public.cargos_abonos (id, monto, operacion, id_cuenta, id_partida) FROM stdin;
    public       postgres    false    185   b5       �
          0    44584    cuentas 
   TABLE DATA               \   COPY public.cuentas (id, codigo, nombre, descripcion, id_superior, tipo, saldo) FROM stdin;
    public       postgres    false    187   �6       �
          0    44589 	   parametro 
   TABLE DATA               B   COPY public.parametro (id, nombre, valor, id_periodo) FROM stdin;
    public       postgres    false    189   �B       �
          0    44592    partidas 
   TABLE DATA               P   COPY public.partidas (id, fecha, descripcion, contador, id_periodo) FROM stdin;
    public       postgres    false    190   �B       �
          0    44599    periodo 
   TABLE DATA               V   COPY public.periodo (id, fecha_inicial, fecha_final, finalizado, encurso) FROM stdin;
    public       postgres    false    193   D                  0    0    cargos_abonos_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.cargos_abonos_id_seq', 1, false);
            public       postgres    false    186                       0    0    cuentas_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.cuentas_id_seq', 1, true);
            public       postgres    false    188                       0    0    partidas_contador_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.partidas_contador_seq', 2, true);
            public       postgres    false    191                       0    0    partidas_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.partidas_id_seq', 1, false);
            public       postgres    false    192                       0    0    periodo_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.periodo_id_seq', 3, true);
            public       postgres    false    194                       0    0    periodo_id_seq1    SEQUENCE SET     =   SELECT pg_catalog.setval('public.periodo_id_seq1', 1, true);
            public       postgres    false    195            f
           2606    44613     cargos_abonos cargos_abonos_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.cargos_abonos
    ADD CONSTRAINT cargos_abonos_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.cargos_abonos DROP CONSTRAINT cargos_abonos_pkey;
       public         postgres    false    185            h
           2606    44615    cuentas cuentas_codigo_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_codigo_key UNIQUE (codigo);
 D   ALTER TABLE ONLY public.cuentas DROP CONSTRAINT cuentas_codigo_key;
       public         postgres    false    187            j
           2606    44617    cuentas cuentas_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.cuentas DROP CONSTRAINT cuentas_pkey;
       public         postgres    false    187            n
           2606    44619    partidas partidas_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.partidas
    ADD CONSTRAINT partidas_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.partidas DROP CONSTRAINT partidas_pkey;
       public         postgres    false    190            l
           2606    44621    parametro periodo_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.parametro
    ADD CONSTRAINT periodo_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.parametro DROP CONSTRAINT periodo_pkey;
       public         postgres    false    189            p
           2606    44623    periodo periodo_pkey1 
   CONSTRAINT     S   ALTER TABLE ONLY public.periodo
    ADD CONSTRAINT periodo_pkey1 PRIMARY KEY (id);
 ?   ALTER TABLE ONLY public.periodo DROP CONSTRAINT periodo_pkey1;
       public         postgres    false    193            q
           2606    44624 *   cargos_abonos cargos_abonos_id_cuenta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cargos_abonos
    ADD CONSTRAINT cargos_abonos_id_cuenta_fkey FOREIGN KEY (id_cuenta) REFERENCES public.cuentas(id);
 T   ALTER TABLE ONLY public.cargos_abonos DROP CONSTRAINT cargos_abonos_id_cuenta_fkey;
       public       postgres    false    185    2666    187            r
           2606    44629 +   cargos_abonos cargos_abonos_id_partida_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cargos_abonos
    ADD CONSTRAINT cargos_abonos_id_partida_fkey FOREIGN KEY (id_partida) REFERENCES public.partidas(id);
 U   ALTER TABLE ONLY public.cargos_abonos DROP CONSTRAINT cargos_abonos_id_partida_fkey;
       public       postgres    false    185    2670    190            s
           2606    44634     cuentas cuentas_id_superior_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_id_superior_fkey FOREIGN KEY (id_superior) REFERENCES public.cuentas(id);
 J   ALTER TABLE ONLY public.cuentas DROP CONSTRAINT cuentas_id_superior_fkey;
       public       postgres    false    187    2666    187            t
           2606    44639    parametro id_periodo_parametro    FK CONSTRAINT     �   ALTER TABLE ONLY public.parametro
    ADD CONSTRAINT id_periodo_parametro FOREIGN KEY (id_periodo) REFERENCES public.periodo(id);
 H   ALTER TABLE ONLY public.parametro DROP CONSTRAINT id_periodo_parametro;
       public       postgres    false    2672    189    193            u
           2606    44644    partidas id_periodo_partida    FK CONSTRAINT        ALTER TABLE ONLY public.partidas
    ADD CONSTRAINT id_periodo_partida FOREIGN KEY (id_periodo) REFERENCES public.periodo(id);
 E   ALTER TABLE ONLY public.partidas DROP CONSTRAINT id_periodo_partida;
       public       postgres    false    190    2672    193            �
   g  x�M�KrE!DǰK~"{�$���!��R�����Z������Cm6R9�M�	���S��$��E��Cg�j�����s�.��ޕ��T�US��g3�Ia�rX�z>�B{�(�U{�9bK��h)��T#yѭ���FA�g� �9��|�P����]K-���+��U���'%#���S����{�X��5tެX���ZX��j�����u��W�.���6�%s�e�	Y���J��Y�2N�DW\�?֞
F���"�70�sh{��W׽��Ȯ�v�8©��������0R�� ���@��cҶ5����v9�=֩�SzvK~�}qz�����C��NZv~f�Qo��      �
   �  x��Z˒�8<�_��n�#D�#D�eLP����i���}��o�;������m{&b�c+`!�,@J�4��b^�$�}H�E|RI�&�8M��.!�|����4�^:��ݯ�y�=��C�6(I��2�5�}�tC7�>I2�P��l��X���Ќ������+=���@Kpꍣ6Ŧ?ot���ɒ��ݿ�f�>�z�ų�#�Tb��n��8�:_�@!Z�A��� �h�Q��3s$�����š���ie��SǏ��i�R�c�Q4���Jn2���p'"�'=��$y�͋���ܿ���Elc� #�}7��� IQ��c���7�$�L�^_�Հǡ�Y8�O�W%����WQ����N�����n��6�1���Ȼ4@i*�'�*qyPI��d\&Z��(�X�Ә���<��w���hhd�W
�U4:��3y˭�H*^�d"�d�$�nA�q2(�Q)��[:"N���u����Џ��hI��t�&��Y�/�?O�ۮ�Eп�S+a�6swY'�Ǿ�D���ԅ�	h����#�v;%�����!/;���2:�B
B�L���/�\o+�1bw=�gX��gzC�ݗ`N�cT��t���{I/��;4�����Y��P�,&�"\�g�xfUV��J�1NYP�0v
-I���6�7ӵ��7��\�Pro<Ͷ�Z�ĦM0uCv�g'@�n��`�X&�F����R�`�Yө#��pR�\ǳ��0ƍ�1Mq9�:z{�Y���׵׭�����s�Ǹ�i,��z�J����)���D�,����Sӛ�WA���Y��Xq�����������@zoM$ϓ���qkw_a�E�ªS��}��Ӿr�
��}�H5H��+G�zԢ���sm/F)r�'l/;�n~��}��`�`)*>����UoH
�,�M�(E�2!?����Z�cTr)���DUڅ�X�Q9R	R�E����&�W�VY�	���,�:����"y�T�Vz��� ���~��i\�g2d��\Y��3/��6(�U�p������y��ֶ�zU�q<��p�ō�5NV�,�Yl���WB�i������qQ��o�R����/J��V��b{Z}�!��<�d��J�Nz!iήg~sG�C�8���@�}�xX�.+����,.ל8f�&S���0�*��88.L� ��c��EІ�y5�|���+=� Uܔ:X�J ��������{��E�����Y�k��$9ٽz* +��n��愌�,�/���
�Ʉ�5��{���>.m��I�Q����ܛ�Vu���C��?��E�ۧ��G���-A���cW 9���I��S�@��U7γ�Ne���y�o�a�5�������)�(��#l�_�a�I�:��Q_IEvk!wgN�2���,%�!,0Ѷ"���4^�_�񖒃���@�[- J ���˛��0*��;w*��^�X)�cӽY Y��v��ji)��;e.�)�qD��O�֣戕1+�^����T�M�>�$����z��c0�H�d�L�J,�ȔL����]�T|)@ci�eT�8z�Xwόrc��P������}��
l{�qbv��+����f��H��j�c���Ę�R��n���w���~����~�c��x�b^I'a�b!���c^&�c���_�=������\�f�tO�a+�o�.&s^T�#�̂x�Rm{���P�d#�q�/���_��.���d��ꆺ%JԎW��<�Wȯ�%�RݠS���R��y��+9�~�E��S:q��zq]�IN��)}N�M�Y����l;N�����r����힄!�l��z�"(�S)��ۍ�I}~t�|'�^����X�n�r!sK�v=�Ȓl#�sY^�Db��9<^�bg�x<�~�OS{��»O�����g���I�:z
�J^����4�x:x
�=y�]9�<Q(��w�0�b���A^?O���a��{�M�g'�KeN�(*��9�G�'9�g���|Вl�]g �$+"��j��PBH2$�D$q	Ɇh��nKHH%�/�/|����U�&��!����2��PW��\�Lh�T|�Q��z�ٮ@֝!H�ӕ�`p%,-{��`�p̃T��7�T.��"^�I��ßo"�4RN�w[ɓ��6x2<jq��k�p������GR��K�S�t2�+W�CJٖ��y��ZI��y�<M���C�VN6���-P!���Mdѷ�m[!�dl=Mg�/�^��%2��8���������~�!'�H�Z�i�TS�Zo��%�|����^��bz1���d�z*ׇᐜ����<=ғM�Ӡ�QCg2����"XCX�w3J5�@HJ&�Z��H�t[���)��s�nn"*�۰!R=��p���wA��D'#������Y���THG^��C�	�����sO����/��s=^ �\���w<�s*p<��5�G�����n�:�y�'� �﹞
}�<� ��z�u��({�G���zZF��A�乞 !��:$��{��9��]��D�s��GC��=�3���z
����C����~��'=�G2����i��G�u�B�c��(R���z*�z�ǐ��x��#�x��"�;��)�g�E�=��H�G�������d��s=�<�Ð|�s=҇��1�z�� l���?�~��������B���n��<�A8e���eG�U�)��IĒ�{�����T�W����_�4���f��2!e�g���x�[��-�3��?v�LP�YB����呢h����?���Pq%O�<�,���Z�o�\��U||����щ�HqC/?��Q�UR(��[�jY�+T�V��T?e��~[�/踬�v���'r^yxf�H��q��)�j���a��3�����T4�J���`L�:ِG�YR�_��#�7-�AC-''�߿��E+�9���?}�����      �
   G   x�3�tsu�p����t�t��420��50"NC.#����L��H�$e����������\� l��      �
     x�uѱN�0���~��\�6�Z�X+&��c!#��$����#��8W�d�n����?BU�a��l�D��6�z�-9@�������Ψ�	�:�/�JT�V�f:�Z�6fb7j;��6z���-[���>���(�,m:��H7a'|��{��!�z�?;;���o��F�o<R8��mH�H�5����^�����.�(������:K��{��h{����^9qrB�	��$�VF~�7!��A��:���,����Ib��u<�x�K�,��4���:{�+��l*�Z      �
   #   x�3�420��50"��H�ؐ3���+F��� c�     