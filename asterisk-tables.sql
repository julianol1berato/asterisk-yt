-- Tabela ps_endpoints
CREATE TABLE ps_endpoints (
    id VARCHAR(40) NOT NULL,
    transport VARCHAR(40),
    aors VARCHAR(200),
    auth VARCHAR(40),
    context VARCHAR(40),
    disallow VARCHAR(200),
    allow VARCHAR(200),
    direct_media VARCHAR(3),
    connected_line_method VARCHAR(60),
    direct_media_method VARCHAR(60),
    direct_media_glare_mitigation VARCHAR(20),
    disable_direct_media_on_nat VARCHAR(3),
    dtmf_mode VARCHAR(15),
    external_media_address VARCHAR(40),
    force_rport VARCHAR(3),
    ice_support VARCHAR(3),
    identify_by VARCHAR(80),
    mailboxes VARCHAR(40),
    moh_suggest VARCHAR(40),
    outbound_auth VARCHAR(40),
    outbound_proxy VARCHAR(40),
    rewrite_contact VARCHAR(3),
    rtp_ipv6 VARCHAR(3),
    rtp_symmetric VARCHAR(3),
    send_diversion VARCHAR(3),
    send_pai VARCHAR(3),
    send_rpid VARCHAR(3),
    timers_min_se INTEGER,
    timers VARCHAR(15),
    timers_sess_expires INTEGER,
    callerid VARCHAR(40),
    callerid_privacy VARCHAR(40),
    callerid_tag VARCHAR(40),
    100rel VARCHAR(3),
    aggregate_mwi VARCHAR(3),
    trust_id_inbound VARCHAR(3),
    trust_id_outbound VARCHAR(3),
    use_ptime VARCHAR(3),
    use_avpf VARCHAR(3),
    media_encryption VARCHAR(15),
    inband_progress VARCHAR(3),
    call_group VARCHAR(40),
    pickup_group VARCHAR(40),
    named_call_group VARCHAR(40),
    named_pickup_group VARCHAR(40),
    device_state_busy_at INTEGER,
    fax_detect VARCHAR(3),
    t38_udptl VARCHAR(3),
    t38_udptl_ec VARCHAR(20),
    t38_udptl_maxdatagram INTEGER,
    t38_udptl_nat VARCHAR(3),
    t38_udptl_ipv6 VARCHAR(3),
    tone_zone VARCHAR(40),
    language VARCHAR(40),
    one_touch_recording VARCHAR(3),
    record_on_feature VARCHAR(40),
    record_off_feature VARCHAR(40),
    rtp_engine VARCHAR(40),
    allow_transfer VARCHAR(3),
    allow_subscribe VARCHAR(3),
    sdp_owner VARCHAR(40),
    sdp_session VARCHAR(40),
    tos_audio INTEGER,
    tos_video INTEGER,
    sub_min_expiry INTEGER,
    from_domain VARCHAR(40),
    from_user VARCHAR(40),
    mwi_from_user VARCHAR(40),
    dtls_verify VARCHAR(40),
    dtls_rekey VARCHAR(40),
    dtls_cert_file VARCHAR(200),
    dtls_private_key VARCHAR(200),
    dtls_cipher VARCHAR(200),
    dtls_ca_file VARCHAR(200),
    dtls_ca_path VARCHAR(200),
    dtls_setup VARCHAR(10),
    srtp_tag_32 VARCHAR(3),
    media_address VARCHAR(40),
    redirect_method VARCHAR(10),
    set_var TEXT,
    cos_audio INTEGER,
    cos_video INTEGER,
    message_context VARCHAR(40),
    force_avp VARCHAR(3),
    media_use_received_transport VARCHAR(3),
    accountcode VARCHAR(80),
    user_eq_phone VARCHAR(3),
    moh_passthrough VARCHAR(3),
    asymmetric_rtp_codec VARCHAR(3),
    rtcp_mux VARCHAR(3),
    allow_overlap VARCHAR(3),
    refer_blind_progress VARCHAR(3),
    notify_early_inuse_ringing VARCHAR(3),
    max_audio_streams INTEGER,
    max_video_streams INTEGER,
    webrtc VARCHAR(3),
    dtls_fingerprint VARCHAR(20),
    incoming_mwi_mailbox VARCHAR(40),
    bundle VARCHAR(3),
    dtls_auto_generate_cert VARCHAR(3),
    follow_early_media_fork VARCHAR(3),
    accept_multiple_sdp_answers VARCHAR(3),
    suppress_q850_reason_headers VARCHAR(3),
    trust_connected_line VARCHAR(3),
    send_connected_line VARCHAR(3),
    ignore_183_without_sdp VARCHAR(3),
    CONSTRAINT ps_endpoints_pkey PRIMARY KEY (id)
);

-- Tabela ps_aors (Address of Record)
CREATE TABLE ps_aors (
    id VARCHAR(40) NOT NULL,
    contact VARCHAR(255),
    default_expiration INTEGER,
    mailboxes VARCHAR(80),
    max_contacts INTEGER,
    minimum_expiration INTEGER,
    remove_existing VARCHAR(3),
    qualify_frequency INTEGER,
    authenticate_qualify VARCHAR(3),
    maximum_expiration INTEGER,
    outbound_proxy VARCHAR(40),
    support_path VARCHAR(3),
    qualify_timeout INTEGER,
    voicemail_extension VARCHAR(40),
    CONSTRAINT ps_aors_pkey PRIMARY KEY (id)
);

-- Tabela ps_auths (Authentication)
CREATE TABLE ps_auths (
    id VARCHAR(40) NOT NULL,
    auth_type VARCHAR(10),
    nonce_lifetime INTEGER,
    md5_cred VARCHAR(40),
    password VARCHAR(80),
    realm VARCHAR(40),
    username VARCHAR(40),
    refresh_token VARCHAR(255),
    oauth_clientid VARCHAR(255),
    oauth_secret VARCHAR(255),
    CONSTRAINT ps_auths_pkey PRIMARY KEY (id)
);

-- Tabela ps_contacts
CREATE TABLE ps_contacts (
    id VARCHAR(255) NOT NULL,
    uri VARCHAR(255),
    expiration_time VARCHAR(40),
    qualify_frequency INTEGER,
    outbound_proxy VARCHAR(40),
    path TEXT,
    user_agent VARCHAR(255),
    qualify_timeout INTEGER,
    reg_server VARCHAR(20),
    authenticate_qualify VARCHAR(3),
    via_addr VARCHAR(40),
    via_port INTEGER,
    call_id VARCHAR(255),
    endpoint VARCHAR(40),
    prune_on_boot VARCHAR(3),
    CONSTRAINT ps_contacts_pkey PRIMARY KEY (id)
);

-- Tabela ps_registrations
CREATE TABLE ps_registrations (
    id VARCHAR(40) NOT NULL,
    client_uri VARCHAR(255),
    contact_user VARCHAR(40),
    contact_header VARCHAR(255),
    expiration INTEGER,
    max_retries INTEGER,
    retry_interval INTEGER,
    forbidden_retry_interval INTEGER,
    server_uri VARCHAR(255),
    transport VARCHAR(40),
    outbound_proxy VARCHAR(40),
    support_path VARCHAR(3),
    fatal_retry_interval INTEGER,
    line VARCHAR(3),
    endpoint VARCHAR(40),
    CONSTRAINT ps_registrations_pkey PRIMARY KEY (id)
);

-- Indexes para melhorar performance
CREATE INDEX ps_endpoints_id_idx ON ps_endpoints (id);
CREATE INDEX ps_aors_id_idx ON ps_aors (id);
CREATE INDEX ps_auths_id_idx ON ps_auths (id);
CREATE INDEX ps_contacts_id_idx ON ps_contacts (id);
CREATE INDEX ps_registrations_id_idx ON ps_registrations (id);