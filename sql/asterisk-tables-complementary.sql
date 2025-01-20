-- Tabela ps_endpoint_id_ips (Identify)
CREATE TABLE ps_endpoint_id_ips (
    id VARCHAR(40) NOT NULL,
    endpoint VARCHAR(40),
    match VARCHAR(80) NOT NULL,
    srv_lookups BOOLEAN,
    match_header VARCHAR(255),
    CONSTRAINT ps_endpoint_id_ips_pkey PRIMARY KEY (id)
);

-- Tabela ps_transports
CREATE TABLE ps_transports (
    id VARCHAR(40) NOT NULL,
    async_operations INTEGER,
    bind VARCHAR(40),
    ca_list_file VARCHAR(200),
    cert_file VARCHAR(200),
    cipher VARCHAR(200),
    domain VARCHAR(40),
    external_media_address VARCHAR(40),
    external_signaling_address VARCHAR(40),
    external_signaling_port INTEGER,
    method VARCHAR(40),
    local_net VARCHAR(40),
    password VARCHAR(40),
    priv_key_file VARCHAR(200),
    protocol VARCHAR(40),
    require_client_cert VARCHAR(3),
    verify_client VARCHAR(3),
    verify_server VARCHAR(3),
    tos VARCHAR(10),
    cos VARCHAR(10),
    allow_reload VARCHAR(3),
    symmetric_transport VARCHAR(3),
    CONSTRAINT ps_transports_pkey PRIMARY KEY (id)
);

-- Tabela ps_subscription_persistence
CREATE TABLE ps_subscription_persistence (
    id VARCHAR(40) NOT NULL,
    packet VARCHAR(2048),
    src_name VARCHAR(128),
    src_port INTEGER,
    transport_key VARCHAR(64),
    local_name VARCHAR(128),
    local_port INTEGER,
    cseq INTEGER,
    tag VARCHAR(128),
    endpoint VARCHAR(40),
    expires INTEGER,
    contact_uri VARCHAR(256),
    prune_on_boot BOOLEAN,
    CONSTRAINT ps_subscription_persistence_pkey PRIMARY KEY (id)
);

-- Tabela ps_outbound_publishes
CREATE TABLE ps_outbound_publishes (
    id VARCHAR(40) NOT NULL,
    expiration INTEGER,
    outbound_auth VARCHAR(40),
    outbound_proxy VARCHAR(256),
    server_uri VARCHAR(256),
    from_uri VARCHAR(256),
    to_uri VARCHAR(256),
    event VARCHAR(40),
    max_auth_attempts INTEGER,
    transport VARCHAR(40),
    multi_user VARCHAR(3),
    @body VARCHAR(40),
    @context VARCHAR(256),
    @exten VARCHAR(256),
    CONSTRAINT ps_outbound_publishes_pkey PRIMARY KEY (id)
);

-- Tabela ps_inbound_publications
CREATE TABLE ps_inbound_publications (
    id VARCHAR(40) NOT NULL,
    endpoint VARCHAR(40),
    event_asterisk-devicestate VARCHAR(40),
    event_asterisk-mwi VARCHAR(40),
    CONSTRAINT ps_inbound_publications_pkey PRIMARY KEY (id)
);

-- Tabela ps_asterisk_publications
CREATE TABLE ps_asterisk_publications (
    id VARCHAR(40) NOT NULL,
    devicestate_publish VARCHAR(40),
    mailboxstate_publish VARCHAR(40),
    device_state VARCHAR(40),
    device_state_filter VARCHAR(256),
    mailbox_state VARCHAR(40),
    mailbox_state_filter VARCHAR(256),
    CONSTRAINT ps_asterisk_publications_pkey PRIMARY KEY (id)
);

-- Tabela ps_resource_list
CREATE TABLE ps_resource_list (
    id VARCHAR(40) NOT NULL,
    list_item VARCHAR(2048),
    event VARCHAR(40),
    full_state BOOLEAN,
    notification_batch_interval INTEGER,
    CONSTRAINT ps_resource_list_pkey PRIMARY KEY (id)
);

-- Indexes para otimização
CREATE INDEX ps_endpoint_id_ips_id_idx ON ps_endpoint_id_ips (id);
CREATE INDEX ps_transports_id_idx ON ps_transports (id);
CREATE INDEX ps_subscription_persistence_id_idx ON ps_subscription_persistence (id);
CREATE INDEX ps_outbound_publishes_id_idx ON ps_outbound_publishes (id);
CREATE INDEX ps_inbound_publications_id_idx ON ps_inbound_publications (id);
CREATE INDEX ps_asterisk_publications_id_idx ON ps_asterisk_publications (id);
CREATE INDEX ps_resource_list_id_idx ON ps_resource_list (id);

-- Foreign Keys para integridade referencial
ALTER TABLE ps_endpoint_id_ips
    ADD CONSTRAINT fk_ps_endpoint_id_ips_endpoint
    FOREIGN KEY (endpoint)
    REFERENCES ps_endpoints(id)
    ON DELETE CASCADE;

ALTER TABLE ps_subscription_persistence
    ADD CONSTRAINT fk_ps_subscription_persistence_endpoint
    FOREIGN KEY (endpoint)
    REFERENCES ps_endpoints(id)
    ON DELETE CASCADE;

ALTER TABLE ps_inbound_publications
    ADD CONSTRAINT fk_ps_inbound_publications_endpoint
    FOREIGN KEY (endpoint)
    REFERENCES ps_endpoints(id)
    ON DELETE CASCADE;
