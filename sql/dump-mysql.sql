create database asterisk;


create table asterisk.extensions
(
    id       bigint auto_increment
        primary key,
    context  varchar(40)  not null,
    exten    varchar(40)  not null,
    priority int          not null,
    app      varchar(40)  not null,
    appdata  varchar(256) not null,
    constraint context
        unique (context, exten, priority),
    constraint id
        unique (id)
);

create table asterisk.iaxfriends
(
    id                int auto_increment
        primary key,
    name              varchar(40)                     not null,
    type              enum ('friend', 'user', 'peer') null,
    username          varchar(40)                     null,
    mailbox           varchar(40)                     null,
    secret            varchar(40)                     null,
    dbsecret          varchar(40)                     null,
    context           varchar(40)                     null,
    regcontext        varchar(40)                     null,
    host              varchar(40)                     null,
    ipaddr            varchar(40)                     null,
    port              int                             null,
    defaultip         varchar(20)                     null,
    sourceaddress     varchar(20)                     null,
    mask              varchar(20)                     null,
    regexten          varchar(40)                     null,
    regseconds        int                             null,
    accountcode       varchar(80)                     null,
    mohinterpret      varchar(20)                     null,
    mohsuggest        varchar(20)                     null,
    inkeys            varchar(40)                     null,
    outkeys           varchar(40)                     null,
    language          varchar(10)                     null,
    callerid          varchar(100)                    null,
    cid_number        varchar(40)                     null,
    sendani           enum ('yes', 'no')              null,
    fullname          varchar(40)                     null,
    trunk             enum ('yes', 'no')              null,
    auth              varchar(20)                     null,
    maxauthreq        int                             null,
    requirecalltoken  enum ('yes', 'no', 'auto')      null,
    encryption        enum ('yes', 'no', 'aes128')    null,
    transfer          enum ('yes', 'no', 'mediaonly') null,
    jitterbuffer      enum ('yes', 'no')              null,
    forcejitterbuffer enum ('yes', 'no')              null,
    disallow          varchar(200)                    null,
    allow             varchar(200)                    null,
    codecpriority     varchar(40)                     null,
    qualify           varchar(10)                     null,
    qualifysmoothing  enum ('yes', 'no')              null,
    qualifyfreqok     varchar(10)                     null,
    qualifyfreqnotok  varchar(10)                     null,
    timezone          varchar(20)                     null,
    adsi              enum ('yes', 'no')              null,
    amaflags          varchar(20)                     null,
    setvar            varchar(200)                    null,
    constraint name
        unique (name)
);

create index iaxfriends_host_port
    on asterisk.iaxfriends (host, port);

create index iaxfriends_ipaddr_port
    on asterisk.iaxfriends (ipaddr, port);

create index iaxfriends_name
    on asterisk.iaxfriends (name);

create index iaxfriends_name_host
    on asterisk.iaxfriends (name, host);

create index iaxfriends_name_ipaddr_port
    on asterisk.iaxfriends (name, ipaddr, port);

create table asterisk.meetme
(
    bookid            int auto_increment
        primary key,
    confno            varchar(80) not null,
    starttime         datetime    null,
    endtime           datetime    null,
    pin               varchar(20) null,
    adminpin          varchar(20) null,
    opts              varchar(20) null,
    adminopts         varchar(20) null,
    recordingfilename varchar(80) null,
    recordingformat   varchar(10) null,
    maxusers          int         null,
    members           int         not null
);

create index meetme_confno_start_end
    on asterisk.meetme (confno, starttime, endtime);

create table asterisk.musiconhold
(
    name        varchar(80)                                                             not null
        primary key,
    mode        enum ('custom', 'files', 'mp3nb', 'quietmp3nb', 'quietmp3', 'playlist') null,
    directory   varchar(255)                                                            null,
    application varchar(255)                                                            null,
    digit       varchar(1)                                                              null,
    sort        varchar(10)                                                             null,
    format      varchar(10)                                                             null,
    stamp       datetime                                                                null
);

create table asterisk.musiconhold_entry
(
    name     varchar(80)   not null,
    position int           not null,
    entry    varchar(1024) not null,
    primary key (name, position),
    constraint fk_musiconhold_entry_name_musiconhold
        foreign key (name) references asterisk.musiconhold (name)
);

create table asterisk.ps_aors
(
    id                   varchar(40)                                                not null,
    contact              varchar(255)                                               null,
    default_expiration   int                                                        null,
    mailboxes            varchar(80)                                                null,
    max_contacts         int                                                        null,
    minimum_expiration   int                                                        null,
    remove_existing      enum ('yes', 'no')                                         null,
    qualify_frequency    int                                                        null,
    authenticate_qualify enum ('yes', 'no')                                         null,
    maximum_expiration   int                                                        null,
    outbound_proxy       varchar(40)                                                null,
    support_path         enum ('yes', 'no')                                         null,
    qualify_timeout      float                                                      null,
    voicemail_extension  varchar(40)                                                null,
    remove_unavailable   enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes') null,
    constraint id
        unique (id)
);

create index ps_aors_id
    on asterisk.ps_aors (id);

create index ps_aors_qualifyfreq_contact
    on asterisk.ps_aors (qualify_frequency, contact);

create table asterisk.ps_asterisk_publications
(
    id                   varchar(40)        not null,
    devicestate_publish  varchar(40)        null,
    mailboxstate_publish varchar(40)        null,
    device_state         enum ('yes', 'no') null,
    device_state_filter  varchar(256)       null,
    mailbox_state        enum ('yes', 'no') null,
    mailbox_state_filter varchar(256)       null,
    constraint id
        unique (id)
);

create index ps_asterisk_publications_id
    on asterisk.ps_asterisk_publications (id);

create table asterisk.ps_auths
(
    id             varchar(40)                              not null,
    auth_type      enum ('md5', 'userpass', 'google_oauth') null,
    nonce_lifetime int                                      null,
    md5_cred       varchar(40)                              null,
    password       varchar(80)                              null,
    realm          varchar(40)                              null,
    username       varchar(40)                              null,
    refresh_token  varchar(255)                             null,
    oauth_clientid varchar(255)                             null,
    oauth_secret   varchar(255)                             null,
    constraint id
        unique (id)
);

create index ps_auths_id
    on asterisk.ps_auths (id);

create table asterisk.ps_contacts
(
    id                   varchar(255)       null,
    uri                  varchar(511)       null,
    expiration_time      bigint             null,
    qualify_frequency    int                null,
    outbound_proxy       varchar(40)        null,
    path                 text               null,
    user_agent           varchar(255)       null,
    qualify_timeout      float              null,
    reg_server           varchar(255)       null,
    authenticate_qualify enum ('yes', 'no') null,
    via_addr             varchar(40)        null,
    via_port             int                null,
    call_id              varchar(255)       null,
    endpoint             varchar(40)        null,
    prune_on_boot        enum ('yes', 'no') null,
    constraint id
        unique (id),
    constraint ps_contacts_uq
        unique (id, reg_server)
);

create index ps_contacts_id
    on asterisk.ps_contacts (id);

create index ps_contacts_qualifyfreq_exp
    on asterisk.ps_contacts (qualify_frequency, expiration_time);

create table asterisk.ps_domain_aliases
(
    id     varchar(40) not null,
    domain varchar(80) null,
    constraint id
        unique (id)
);

create index ps_domain_aliases_id
    on asterisk.ps_domain_aliases (id);

create table asterisk.ps_endpoint_id_ips
(
    id           varchar(40)        not null,
    endpoint     varchar(40)        null,
    `match`      varchar(80)        null,
    srv_lookups  enum ('yes', 'no') null,
    match_header varchar(255)       null,
    constraint id
        unique (id)
);

create index ps_endpoint_id_ips_id
    on asterisk.ps_endpoint_id_ips (id);

create table asterisk.ps_endpoints
(
    id                                 varchar(40)                                                                                                                                                                                        not null,
    transport                          varchar(40)                                                                                                                                                                                        null,
    aors                               varchar(200)                                                                                                                                                                                       null,
    auth                               varchar(40)                                                                                                                                                                                        null,
    context                            varchar(40)                                                                                                                                                                                        null,
    disallow                           varchar(200)                                                                                                                                                                                       null,
    allow                              varchar(200)                                                                                                                                                                                       null,
    direct_media                       enum ('yes', 'no')                                                                                                                                                                                 null,
    connected_line_method              enum ('invite', 'reinvite', 'update')                                                                                                                                                              null,
    direct_media_method                enum ('invite', 'reinvite', 'update')                                                                                                                                                              null,
    direct_media_glare_mitigation      enum ('none', 'outgoing', 'incoming')                                                                                                                                                              null,
    disable_direct_media_on_nat        enum ('yes', 'no')                                                                                                                                                                                 null,
    dtmf_mode                          enum ('rfc4733', 'inband', 'info', 'auto', 'auto_info')                                                                                                                                            null,
    external_media_address             varchar(40)                                                                                                                                                                                        null,
    force_rport                        enum ('yes', 'no')                                                                                                                                                                                 null,
    ice_support                        enum ('yes', 'no')                                                                                                                                                                                 null,
    identify_by                        varchar(80)                                                                                                                                                                                        null,
    mailboxes                          varchar(40)                                                                                                                                                                                        null,
    moh_suggest                        varchar(40)                                                                                                                                                                                        null,
    outbound_auth                      varchar(40)                                                                                                                                                                                        null,
    outbound_proxy                     varchar(40)                                                                                                                                                                                        null,
    rewrite_contact                    enum ('yes', 'no')                                                                                                                                                                                 null,
    rtp_ipv6                           enum ('yes', 'no')                                                                                                                                                                                 null,
    rtp_symmetric                      enum ('yes', 'no')                                                                                                                                                                                 null,
    send_diversion                     enum ('yes', 'no')                                                                                                                                                                                 null,
    send_pai                           enum ('yes', 'no')                                                                                                                                                                                 null,
    send_rpid                          enum ('yes', 'no')                                                                                                                                                                                 null,
    timers_min_se                      int                                                                                                                                                                                                null,
    timers                             enum ('forced', 'no', 'required', 'yes')                                                                                                                                                           null,
    timers_sess_expires                int                                                                                                                                                                                                null,
    callerid                           varchar(40)                                                                                                                                                                                        null,
    callerid_privacy                   enum ('allowed_not_screened', 'allowed_passed_screened', 'allowed_failed_screened', 'allowed', 'prohib_not_screened', 'prohib_passed_screened', 'prohib_failed_screened', 'prohib', 'unavailable') null,
    callerid_tag                       varchar(40)                                                                                                                                                                                        null,
    `100rel`                           enum ('no', 'required', 'peer_supported', 'yes')                                                                                                                                                   null,
    aggregate_mwi                      enum ('yes', 'no')                                                                                                                                                                                 null,
    trust_id_inbound                   enum ('yes', 'no')                                                                                                                                                                                 null,
    trust_id_outbound                  enum ('yes', 'no')                                                                                                                                                                                 null,
    use_ptime                          enum ('yes', 'no')                                                                                                                                                                                 null,
    use_avpf                           enum ('yes', 'no')                                                                                                                                                                                 null,
    media_encryption                   enum ('no', 'sdes', 'dtls')                                                                                                                                                                        null,
    inband_progress                    enum ('yes', 'no')                                                                                                                                                                                 null,
    call_group                         varchar(40)                                                                                                                                                                                        null,
    pickup_group                       varchar(40)                                                                                                                                                                                        null,
    named_call_group                   varchar(40)                                                                                                                                                                                        null,
    named_pickup_group                 varchar(40)                                                                                                                                                                                        null,
    device_state_busy_at               int                                                                                                                                                                                                null,
    fax_detect                         enum ('yes', 'no')                                                                                                                                                                                 null,
    t38_udptl                          enum ('yes', 'no')                                                                                                                                                                                 null,
    t38_udptl_ec                       enum ('none', 'fec', 'redundancy')                                                                                                                                                                 null,
    t38_udptl_maxdatagram              int                                                                                                                                                                                                null,
    t38_udptl_nat                      enum ('yes', 'no')                                                                                                                                                                                 null,
    t38_udptl_ipv6                     enum ('yes', 'no')                                                                                                                                                                                 null,
    tone_zone                          varchar(40)                                                                                                                                                                                        null,
    language                           varchar(40)                                                                                                                                                                                        null,
    one_touch_recording                enum ('yes', 'no')                                                                                                                                                                                 null,
    record_on_feature                  varchar(40)                                                                                                                                                                                        null,
    record_off_feature                 varchar(40)                                                                                                                                                                                        null,
    rtp_engine                         varchar(40)                                                                                                                                                                                        null,
    allow_transfer                     enum ('yes', 'no')                                                                                                                                                                                 null,
    allow_subscribe                    enum ('yes', 'no')                                                                                                                                                                                 null,
    sdp_owner                          varchar(40)                                                                                                                                                                                        null,
    sdp_session                        varchar(40)                                                                                                                                                                                        null,
    tos_audio                          varchar(10)                                                                                                                                                                                        null,
    tos_video                          varchar(10)                                                                                                                                                                                        null,
    sub_min_expiry                     int                                                                                                                                                                                                null,
    from_domain                        varchar(40)                                                                                                                                                                                        null,
    from_user                          varchar(40)                                                                                                                                                                                        null,
    mwi_from_user                      varchar(40)                                                                                                                                                                                        null,
    dtls_verify                        varchar(40)                                                                                                                                                                                        null,
    dtls_rekey                         varchar(40)                                                                                                                                                                                        null,
    dtls_cert_file                     varchar(200)                                                                                                                                                                                       null,
    dtls_private_key                   varchar(200)                                                                                                                                                                                       null,
    dtls_cipher                        varchar(200)                                                                                                                                                                                       null,
    dtls_ca_file                       varchar(200)                                                                                                                                                                                       null,
    dtls_ca_path                       varchar(200)                                                                                                                                                                                       null,
    dtls_setup                         enum ('active', 'passive', 'actpass')                                                                                                                                                              null,
    srtp_tag_32                        enum ('yes', 'no')                                                                                                                                                                                 null,
    media_address                      varchar(40)                                                                                                                                                                                        null,
    redirect_method                    enum ('user', 'uri_core', 'uri_pjsip')                                                                                                                                                             null,
    set_var                            text                                                                                                                                                                                               null,
    cos_audio                          int                                                                                                                                                                                                null,
    cos_video                          int                                                                                                                                                                                                null,
    message_context                    varchar(40)                                                                                                                                                                                        null,
    force_avp                          enum ('yes', 'no')                                                                                                                                                                                 null,
    media_use_received_transport       enum ('yes', 'no')                                                                                                                                                                                 null,
    accountcode                        varchar(80)                                                                                                                                                                                        null,
    user_eq_phone                      enum ('yes', 'no')                                                                                                                                                                                 null,
    moh_passthrough                    enum ('yes', 'no')                                                                                                                                                                                 null,
    media_encryption_optimistic        enum ('yes', 'no')                                                                                                                                                                                 null,
    rpid_immediate                     enum ('yes', 'no')                                                                                                                                                                                 null,
    g726_non_standard                  enum ('yes', 'no')                                                                                                                                                                                 null,
    rtp_keepalive                      int                                                                                                                                                                                                null,
    rtp_timeout                        int                                                                                                                                                                                                null,
    rtp_timeout_hold                   int                                                                                                                                                                                                null,
    bind_rtp_to_media_address          enum ('yes', 'no')                                                                                                                                                                                 null,
    voicemail_extension                varchar(40)                                                                                                                                                                                        null,
    mwi_subscribe_replaces_unsolicited enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes')                                                                                                                                         null,
    deny                               varchar(95)                                                                                                                                                                                        null,
    permit                             varchar(95)                                                                                                                                                                                        null,
    acl                                varchar(40)                                                                                                                                                                                        null,
    contact_deny                       varchar(95)                                                                                                                                                                                        null,
    contact_permit                     varchar(95)                                                                                                                                                                                        null,
    contact_acl                        varchar(40)                                                                                                                                                                                        null,
    subscribe_context                  varchar(40)                                                                                                                                                                                        null,
    fax_detect_timeout                 int                                                                                                                                                                                                null,
    contact_user                       varchar(80)                                                                                                                                                                                        null,
    preferred_codec_only               enum ('yes', 'no')                                                                                                                                                                                 null,
    asymmetric_rtp_codec               enum ('yes', 'no')                                                                                                                                                                                 null,
    rtcp_mux                           enum ('yes', 'no')                                                                                                                                                                                 null,
    allow_overlap                      enum ('yes', 'no')                                                                                                                                                                                 null,
    refer_blind_progress               enum ('yes', 'no')                                                                                                                                                                                 null,
    notify_early_inuse_ringing         enum ('yes', 'no')                                                                                                                                                                                 null,
    max_audio_streams                  int                                                                                                                                                                                                null,
    max_video_streams                  int                                                                                                                                                                                                null,
    webrtc                             enum ('yes', 'no')                                                                                                                                                                                 null,
    dtls_fingerprint                   enum ('SHA-1', 'SHA-256')                                                                                                                                                                          null,
    incoming_mwi_mailbox               varchar(40)                                                                                                                                                                                        null,
    bundle                             enum ('yes', 'no')                                                                                                                                                                                 null,
    dtls_auto_generate_cert            enum ('yes', 'no')                                                                                                                                                                                 null,
    follow_early_media_fork            enum ('yes', 'no')                                                                                                                                                                                 null,
    accept_multiple_sdp_answers        enum ('yes', 'no')                                                                                                                                                                                 null,
    suppress_q850_reason_headers       enum ('yes', 'no')                                                                                                                                                                                 null,
    trust_connected_line               enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes')                                                                                                                                         null,
    send_connected_line                enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes')                                                                                                                                         null,
    ignore_183_without_sdp             enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes')                                                                                                                                         null,
    codec_prefs_incoming_offer         varchar(128)                                                                                                                                                                                       null,
    codec_prefs_outgoing_offer         varchar(128)                                                                                                                                                                                       null,
    codec_prefs_incoming_answer        varchar(128)                                                                                                                                                                                       null,
    codec_prefs_outgoing_answer        varchar(128)                                                                                                                                                                                       null,
    stir_shaken                        enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes')                                                                                                                                         null,
    send_history_info                  enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes')                                                                                                                                         null,
    allow_unauthenticated_options      enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes')                                                                                                                                         null,
    t38_bind_udptl_to_media_address    enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes')                                                                                                                                         null,
    geoloc_incoming_call_profile       varchar(80)                                                                                                                                                                                        null,
    geoloc_outgoing_call_profile       varchar(80)                                                                                                                                                                                        null,
    incoming_call_offer_pref           enum ('local', 'local_first', 'remote', 'remote_first')                                                                                                                                            null,
    outgoing_call_offer_pref           enum ('local', 'local_merge', 'local_first', 'remote', 'remote_merge', 'remote_first')                                                                                                             null,
    stir_shaken_profile                varchar(80)                                                                                                                                                                                        null,
    security_negotiation               enum ('no', 'mediasec')                                                                                                                                                                            null,
    security_mechanisms                varchar(512)                                                                                                                                                                                       null,
    send_aoc                           enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes')                                                                                                                                         null,
    overlap_context                    varchar(80)                                                                                                                                                                                        null,
    constraint id
        unique (id)
);

create index ps_endpoints_id
    on asterisk.ps_endpoints (id);

create table asterisk.ps_globals
(
    id                                         varchar(40)                                                not null,
    max_forwards                               int                                                        null,
    user_agent                                 varchar(255)                                               null,
    default_outbound_endpoint                  varchar(40)                                                null,
    debug                                      varchar(40)                                                null,
    endpoint_identifier_order                  varchar(40)                                                null,
    max_initial_qualify_time                   int                                                        null,
    default_from_user                          varchar(80)                                                null,
    keep_alive_interval                        int                                                        null,
    regcontext                                 varchar(80)                                                null,
    contact_expiration_check_interval          int                                                        null,
    default_voicemail_extension                varchar(40)                                                null,
    disable_multi_domain                       enum ('yes', 'no')                                         null,
    unidentified_request_count                 int                                                        null,
    unidentified_request_period                int                                                        null,
    unidentified_request_prune_interval        int                                                        null,
    default_realm                              varchar(40)                                                null,
    mwi_tps_queue_high                         int                                                        null,
    mwi_tps_queue_low                          int                                                        null,
    mwi_disable_initial_unsolicited            enum ('yes', 'no')                                         null,
    ignore_uri_user_options                    enum ('yes', 'no')                                         null,
    use_callerid_contact                       enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes') null,
    send_contact_status_on_update_registration enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes') null,
    taskprocessor_overload_trigger             enum ('none', 'global', 'pjsip_only')                      null,
    norefersub                                 enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes') null,
    allow_sending_180_after_183                enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes') null,
    all_codecs_on_empty_reinvite               enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes') null,
    constraint id
        unique (id)
);

create index ps_globals_id
    on asterisk.ps_globals (id);

create table asterisk.ps_inbound_publications
(
    id                           varchar(40) not null,
    endpoint                     varchar(40) null,
    `event_asterisk-devicestate` varchar(40) null,
    `event_asterisk-mwi`         varchar(40) null,
    constraint id
        unique (id)
);

create index ps_inbound_publications_id
    on asterisk.ps_inbound_publications (id);

create table asterisk.ps_outbound_publishes
(
    id                varchar(40)        not null,
    expiration        int                null,
    outbound_auth     varchar(40)        null,
    outbound_proxy    varchar(256)       null,
    server_uri        varchar(256)       null,
    from_uri          varchar(256)       null,
    to_uri            varchar(256)       null,
    event             varchar(40)        null,
    max_auth_attempts int                null,
    transport         varchar(40)        null,
    multi_user        enum ('yes', 'no') null,
    `@body`           varchar(40)        null,
    `@context`        varchar(256)       null,
    `@exten`          varchar(256)       null,
    constraint id
        unique (id)
);

create index ps_outbound_publishes_id
    on asterisk.ps_outbound_publishes (id);

create table asterisk.ps_registrations
(
    id                       varchar(40)                                                not null,
    auth_rejection_permanent enum ('yes', 'no')                                         null,
    client_uri               varchar(255)                                               null,
    contact_user             varchar(40)                                                null,
    expiration               int                                                        null,
    max_retries              int                                                        null,
    outbound_auth            varchar(40)                                                null,
    outbound_proxy           varchar(40)                                                null,
    retry_interval           int                                                        null,
    forbidden_retry_interval int                                                        null,
    server_uri               varchar(255)                                               null,
    transport                varchar(40)                                                null,
    support_path             enum ('yes', 'no')                                         null,
    fatal_retry_interval     int                                                        null,
    line                     enum ('yes', 'no')                                         null,
    endpoint                 varchar(40)                                                null,
    support_outbound         enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes') null,
    contact_header_params    varchar(255)                                               null,
    max_random_initial_delay int                                                        null,
    security_negotiation     enum ('no', 'mediasec')                                    null,
    security_mechanisms      varchar(512)                                               null,
    constraint id
        unique (id)
);

create index ps_registrations_id
    on asterisk.ps_registrations (id);

create table asterisk.ps_resource_list
(
    id                          varchar(40)                                                not null,
    list_item                   varchar(2048)                                              null,
    event                       varchar(40)                                                null,
    full_state                  enum ('yes', 'no')                                         null,
    notification_batch_interval int                                                        null,
    resource_display_name       enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes') null,
    constraint id
        unique (id)
);

create index ps_resource_list_id
    on asterisk.ps_resource_list (id);

create table asterisk.ps_subscription_persistence
(
    id            varchar(40)        not null,
    packet        varchar(2048)      null,
    src_name      varchar(128)       null,
    src_port      int                null,
    transport_key varchar(64)        null,
    local_name    varchar(128)       null,
    local_port    int                null,
    cseq          int                null,
    tag           varchar(128)       null,
    endpoint      varchar(40)        null,
    expires       int                null,
    contact_uri   varchar(256)       null,
    prune_on_boot enum ('yes', 'no') null,
    constraint id
        unique (id)
);

create index ps_subscription_persistence_id
    on asterisk.ps_subscription_persistence (id);

create table asterisk.ps_systems
(
    id                          varchar(40)                                                not null,
    timer_t1                    int                                                        null,
    timer_b                     int                                                        null,
    compact_headers             enum ('yes', 'no')                                         null,
    threadpool_initial_size     int                                                        null,
    threadpool_auto_increment   int                                                        null,
    threadpool_idle_timeout     int                                                        null,
    threadpool_max_size         int                                                        null,
    disable_tcp_switch          enum ('yes', 'no')                                         null,
    follow_early_media_fork     enum ('yes', 'no')                                         null,
    accept_multiple_sdp_answers enum ('yes', 'no')                                         null,
    disable_rport               enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes') null,
    constraint id
        unique (id)
);

create index ps_systems_id
    on asterisk.ps_systems (id);

create table asterisk.ps_transports
(
    id                         varchar(40)                                                          not null,
    async_operations           int                                                                  null,
    bind                       varchar(40)                                                          null,
    ca_list_file               varchar(200)                                                         null,
    cert_file                  varchar(200)                                                         null,
    cipher                     varchar(200)                                                         null,
    domain                     varchar(40)                                                          null,
    external_media_address     varchar(40)                                                          null,
    external_signaling_address varchar(40)                                                          null,
    external_signaling_port    int                                                                  null,
    method                     enum ('default', 'unspecified', 'tlsv1', 'sslv2', 'sslv3', 'sslv23') null,
    local_net                  varchar(40)                                                          null,
    password                   varchar(40)                                                          null,
    priv_key_file              varchar(200)                                                         null,
    protocol                   enum ('udp', 'tcp', 'tls', 'ws', 'wss', 'flow')                      null,
    require_client_cert        enum ('yes', 'no')                                                   null,
    verify_client              enum ('yes', 'no')                                                   null,
    verify_server              enum ('yes', 'no')                                                   null,
    tos                        varchar(10)                                                          null,
    cos                        int                                                                  null,
    allow_reload               enum ('yes', 'no')                                                   null,
    symmetric_transport        enum ('yes', 'no')                                                   null,
    allow_wildcard_certs       enum ('yes', 'no')                                                   null,
    constraint id
        unique (id)
);

create index ps_transports_id
    on asterisk.ps_transports (id);

create table asterisk.queue_log
(
    id        bigint(255) unsigned auto_increment
        primary key,
    time      varchar(26)  default ''                  not null,
    callid    varchar(40)  default ''                  not null,
    queuename varchar(20)  default ''                  not null,
    agent     varchar(20)  default ''                  not null,
    event     varchar(20)  default ''                  not null,
    data      varchar(100) default ''                  not null,
    data1     varchar(40)  default ''                  not null,
    data2     varchar(40)  default ''                  not null,
    data3     varchar(40)  default ''                  not null,
    data4     varchar(40)  default ''                  not null,
    data5     varchar(40)  default ''                  not null,
    created   timestamp    default current_timestamp() not null
)
    charset = utf8;

create index event
    on asterisk.queue_log (event);

create index queue
    on asterisk.queue_log (queuename);

create table asterisk.queue_members
(
    queue_name      varchar(80)                                                not null,
    interface       varchar(80)                                                not null,
    membername      varchar(80)                                                null,
    state_interface varchar(80)                                                null,
    penalty         int                                                        null,
    paused          int                                                        null,
    uniqueid        int auto_increment,
    wrapuptime      int                                                        null,
    ringinuse       enum ('0', '1', 'off', 'on', 'false', 'true', 'no', 'yes') null,
    primary key (queue_name, interface),
    constraint uniqueid
        unique (uniqueid)
);

create table asterisk.queue_rules
(
    rule_name   varchar(80) not null,
    time        varchar(32) not null,
    min_penalty varchar(32) not null,
    max_penalty varchar(32) not null
);

create table asterisk.queues
(
    name                        varchar(128)                                                                                           not null
        primary key,
    musiconhold                 varchar(128)                                                                                           null,
    announce                    varchar(128)                                                                                           null,
    context                     varchar(128)                                                                                           null,
    timeout                     int                                                                                                    null,
    ringinuse                   enum ('yes', 'no')                                                                                     null,
    setinterfacevar             enum ('yes', 'no')                                                                                     null,
    setqueuevar                 enum ('yes', 'no')                                                                                     null,
    setqueueentryvar            enum ('yes', 'no')                                                                                     null,
    monitor_format              varchar(8)                                                                                             null,
    membermacro                 varchar(512)                                                                                           null,
    membergosub                 varchar(512)                                                                                           null,
    queue_youarenext            varchar(128)                                                                                           null,
    queue_thereare              varchar(128)                                                                                           null,
    queue_callswaiting          varchar(128)                                                                                           null,
    queue_quantity1             varchar(128)                                                                                           null,
    queue_quantity2             varchar(128)                                                                                           null,
    queue_holdtime              varchar(128)                                                                                           null,
    queue_minutes               varchar(128)                                                                                           null,
    queue_minute                varchar(128)                                                                                           null,
    queue_seconds               varchar(128)                                                                                           null,
    queue_thankyou              varchar(128)                                                                                           null,
    queue_callerannounce        varchar(128)                                                                                           null,
    queue_reporthold            varchar(128)                                                                                           null,
    announce_frequency          int                                                                                                    null,
    announce_to_first_user      enum ('yes', 'no')                                                                                     null,
    min_announce_frequency      int                                                                                                    null,
    announce_round_seconds      int                                                                                                    null,
    announce_holdtime           varchar(128)                                                                                           null,
    announce_position           varchar(128)                                                                                           null,
    announce_position_limit     int                                                                                                    null,
    periodic_announce           varchar(50)                                                                                            null,
    periodic_announce_frequency int                                                                                                    null,
    relative_periodic_announce  enum ('yes', 'no')                                                                                     null,
    random_periodic_announce    enum ('yes', 'no')                                                                                     null,
    retry                       int                                                                                                    null,
    wrapuptime                  int                                                                                                    null,
    penaltymemberslimit         int                                                                                                    null,
    autofill                    enum ('yes', 'no')                                                                                     null,
    monitor_type                varchar(128)                                                                                           null,
    autopause                   enum ('yes', 'no', 'all')                                                                              null,
    autopausedelay              int                                                                                                    null,
    autopausebusy               enum ('yes', 'no')                                                                                     null,
    autopauseunavail            enum ('yes', 'no')                                                                                     null,
    maxlen                      int                                                                                                    null,
    servicelevel                int                                                                                                    null,
    strategy                    enum ('ringall', 'leastrecent', 'fewestcalls', 'random', 'rrmemory', 'linear', 'wrandom', 'rrordered') null,
    joinempty                   varchar(128)                                                                                           null,
    leavewhenempty              varchar(128)                                                                                           null,
    reportholdtime              enum ('yes', 'no')                                                                                     null,
    memberdelay                 int                                                                                                    null,
    weight                      int                                                                                                    null,
    timeoutrestart              enum ('yes', 'no')                                                                                     null,
    defaultrule                 varchar(128)                                                                                           null,
    timeoutpriority             varchar(128)                                                                                           null
);

create table asterisk.sippeers
(
    id                  int auto_increment
        primary key,
    name                varchar(40)                                                                                                                                                                 not null,
    ipaddr              varchar(45)                                                                                                                                                                 null,
    port                int                                                                                                                                                                         null,
    regseconds          int                                                                                                                                                                         null,
    defaultuser         varchar(40)                                                                                                                                                                 null,
    fullcontact         varchar(80)                                                                                                                                                                 null,
    regserver           varchar(20)                                                                                                                                                                 null,
    useragent           varchar(255)                                                                                                                                                                null,
    lastms              int                                                                                                                                                                         null,
    host                varchar(40)                                                                                                                                                                 null,
    type                enum ('friend', 'user', 'peer')                                                                                                                                             null,
    context             varchar(40)                                                                                                                                                                 null,
    permit              varchar(95)                                                                                                                                                                 null,
    deny                varchar(95)                                                                                                                                                                 null,
    secret              varchar(40)                                                                                                                                                                 null,
    md5secret           varchar(40)                                                                                                                                                                 null,
    remotesecret        varchar(40)                                                                                                                                                                 null,
    transport           enum ('udp', 'tcp', 'tls', 'ws', 'wss', 'udp, tcp', 'tcp, udp')                                                                                                             null,
    dtmfmode            enum ('rfc2833', 'info', 'shortinfo', 'inband', 'auto')                                                                                                                     null,
    directmedia         enum ('yes', 'no', 'nonat', 'update', 'outgoing')                                                                                                                           null,
    nat                 varchar(29)                                                                                                                                                                 null,
    callgroup           varchar(40)                                                                                                                                                                 null,
    pickupgroup         varchar(40)                                                                                                                                                                 null,
    language            varchar(40)                                                                                                                                                                 null,
    disallow            varchar(200)                                                                                                                                                                null,
    allow               varchar(200)                                                                                                                                                                null,
    insecure            varchar(40)                                                                                                                                                                 null,
    trustrpid           enum ('yes', 'no')                                                                                                                                                          null,
    progressinband      enum ('yes', 'no', 'never')                                                                                                                                                 null,
    promiscredir        enum ('yes', 'no')                                                                                                                                                          null,
    useclientcode       enum ('yes', 'no')                                                                                                                                                          null,
    accountcode         varchar(80)                                                                                                                                                                 null,
    setvar              varchar(200)                                                                                                                                                                null,
    callerid            varchar(40)                                                                                                                                                                 null,
    amaflags            varchar(40)                                                                                                                                                                 null,
    callcounter         enum ('yes', 'no')                                                                                                                                                          null,
    busylevel           int                                                                                                                                                                         null,
    allowoverlap        enum ('yes', 'no')                                                                                                                                                          null,
    allowsubscribe      enum ('yes', 'no')                                                                                                                                                          null,
    videosupport        enum ('yes', 'no')                                                                                                                                                          null,
    maxcallbitrate      int                                                                                                                                                                         null,
    rfc2833compensate   enum ('yes', 'no')                                                                                                                                                          null,
    mailbox             varchar(40)                                                                                                                                                                 null,
    `session-timers`    enum ('accept', 'refuse', 'originate')                                                                                                                                      null,
    `session-expires`   int                                                                                                                                                                         null,
    `session-minse`     int                                                                                                                                                                         null,
    `session-refresher` enum ('uac', 'uas')                                                                                                                                                         null,
    t38pt_usertpsource  varchar(40)                                                                                                                                                                 null,
    regexten            varchar(40)                                                                                                                                                                 null,
    fromdomain          varchar(40)                                                                                                                                                                 null,
    fromuser            varchar(40)                                                                                                                                                                 null,
    qualify             varchar(40)                                                                                                                                                                 null,
    defaultip           varchar(45)                                                                                                                                                                 null,
    rtptimeout          int                                                                                                                                                                         null,
    rtpholdtimeout      int                                                                                                                                                                         null,
    sendrpid            enum ('yes', 'no')                                                                                                                                                          null,
    outboundproxy       varchar(40)                                                                                                                                                                 null,
    callbackextension   varchar(40)                                                                                                                                                                 null,
    timert1             int                                                                                                                                                                         null,
    timerb              int                                                                                                                                                                         null,
    qualifyfreq         int                                                                                                                                                                         null,
    constantssrc        enum ('yes', 'no')                                                                                                                                                          null,
    contactpermit       varchar(95)                                                                                                                                                                 null,
    contactdeny         varchar(95)                                                                                                                                                                 null,
    usereqphone         enum ('yes', 'no')                                                                                                                                                          null,
    textsupport         enum ('yes', 'no')                                                                                                                                                          null,
    faxdetect           enum ('yes', 'no')                                                                                                                                                          null,
    buggymwi            enum ('yes', 'no')                                                                                                                                                          null,
    auth                varchar(40)                                                                                                                                                                 null,
    fullname            varchar(40)                                                                                                                                                                 null,
    trunkname           varchar(40)                                                                                                                                                                 null,
    cid_number          varchar(40)                                                                                                                                                                 null,
    callingpres         enum ('allowed_not_screened', 'allowed_passed_screen', 'allowed_failed_screen', 'allowed', 'prohib_not_screened', 'prohib_passed_screen', 'prohib_failed_screen', 'prohib') null,
    mohinterpret        varchar(40)                                                                                                                                                                 null,
    mohsuggest          varchar(40)                                                                                                                                                                 null,
    parkinglot          varchar(40)                                                                                                                                                                 null,
    hasvoicemail        enum ('yes', 'no')                                                                                                                                                          null,
    subscribemwi        enum ('yes', 'no')                                                                                                                                                          null,
    vmexten             varchar(40)                                                                                                                                                                 null,
    autoframing         enum ('yes', 'no')                                                                                                                                                          null,
    rtpkeepalive        int                                                                                                                                                                         null,
    `call-limit`        int                                                                                                                                                                         null,
    g726nonstandard     enum ('yes', 'no')                                                                                                                                                          null,
    ignoresdpversion    enum ('yes', 'no')                                                                                                                                                          null,
    allowtransfer       enum ('yes', 'no')                                                                                                                                                          null,
    dynamic             enum ('yes', 'no')                                                                                                                                                          null,
    path                varchar(256)                                                                                                                                                                null,
    supportpath         enum ('yes', 'no')                                                                                                                                                          null,
    constraint name
        unique (name)
);

create index sippeers_host_port
    on asterisk.sippeers (host, port);

create index sippeers_ipaddr_port
    on asterisk.sippeers (ipaddr, port);

create index sippeers_name
    on asterisk.sippeers (name);

create index sippeers_name_host
    on asterisk.sippeers (name, host);

create table asterisk.voicemail
(
    uniqueid        int auto_increment
        primary key,
    context         varchar(80)        not null,
    mailbox         varchar(80)        not null,
    password        varchar(80)        not null,
    fullname        varchar(80)        null,
    alias           varchar(80)        null,
    email           varchar(80)        null,
    pager           varchar(80)        null,
    attach          enum ('yes', 'no') null,
    attachfmt       varchar(10)        null,
    serveremail     varchar(80)        null,
    language        varchar(20)        null,
    tz              varchar(30)        null,
    deletevoicemail enum ('yes', 'no') null,
    saycid          enum ('yes', 'no') null,
    sendvoicemail   enum ('yes', 'no') null,
    review          enum ('yes', 'no') null,
    tempgreetwarn   enum ('yes', 'no') null,
    operator        enum ('yes', 'no') null,
    envelope        enum ('yes', 'no') null,
    sayduration     int                null,
    forcename       enum ('yes', 'no') null,
    forcegreetings  enum ('yes', 'no') null,
    callback        varchar(80)        null,
    dialout         varchar(80)        null,
    exitcontext     varchar(80)        null,
    maxmsg          int                null,
    volgain         decimal(5, 2)      null,
    imapuser        varchar(80)        null,
    imappassword    varchar(80)        null,
    imapserver      varchar(80)        null,
    imapport        varchar(8)         null,
    imapflags       varchar(80)        null,
    stamp           datetime           null
);

create index voicemail_context
    on asterisk.voicemail (context);

create index voicemail_imapuser
    on asterisk.voicemail (imapuser);

create index voicemail_mailbox
    on asterisk.voicemail (mailbox);

create index voicemail_mailbox_context
    on asterisk.voicemail (mailbox, context);

