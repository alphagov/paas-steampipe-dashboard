<!-- generated file so do not edit by hand! -->
# Schemata

##  data/aiven/aiven_instances.csv

|seq|field|
---|------|
|1|service_name|
|2|region|
|3|service_type|
|4|plan|

##  data/aws/application_load_balancers.csv

|seq|field|
---|------|
|1|name|
|2|arn|
|3|type|
|4|scheme|
|5|canonical_hosted_zone_id|
|6|vpc_id|
|7|created_time|
|8|customer_owned_ipv4_pool|
|9|dns_name|
|10|ip_address_type|
|11|state_code|
|12|state_reason|
|13|availability_zones|
|14|security_groups|
|15|load_balancer_attributes|
|16|tags_src|
|17|tags|
|18|title|
|19|akas|
|20|partition|
|21|region|
|22|account_id|
|23|_ctx|

##  data/aws/cloudfront_distributions.csv

|seq|field|
---|------|
|1|id|
|2|arn|
|3|status|
|4|caller_reference|
|5|comment|
|6|default_root_object|
|7|domain_name|
|8|enabled|
|9|e_tag|
|10|http_version|
|11|is_ipv6_enabled|
|12|in_progress_invalidation_batches|
|13|last_modified_time|
|14|price_class|
|15|web_acl_id|
|16|active_trusted_key_groups|
|17|active_trusted_signers|
|18|aliases|
|19|alias_icp_recordals|
|20|cache_behaviors|
|21|custom_error_responses|
|22|default_cache_behavior|
|23|logging|
|24|origins|
|25|origin_groups|
|26|restrictions|
|27|tags_src|
|28|viewer_certificate|
|29|title|
|30|tags|
|31|akas|
|32|partition|
|33|region|
|34|account_id|
|35|_ctx|

##  data/aws/ebs_snapshots.csv

|seq|field|
---|------|
|1|snapshot_id|
|2|arn|
|3|state|
|4|volume_size|
|5|volume_id|
|6|encrypted|
|7|start_time|
|8|description|
|9|kms_key_id|
|10|data_encryption_key_id|
|11|progress|
|12|state_message|
|13|owner_alias|
|14|owner_id|
|15|create_volume_permissions|
|16|tags_src|
|17|title|
|18|tags|
|19|akas|
|20|partition|
|21|region|
|22|account_id|
|23|_ctx|

##  data/aws/ebs_volumes.csv

|seq|field|
---|------|
|1|volume_id|
|2|arn|
|3|volume_type|
|4|state|
|5|create_time|
|6|auto_enable_io|
|7|availability_zone|
|8|encrypted|
|9|fast_restored|
|10|iops|
|11|kms_key_id|
|12|multi_attach_enabled|
|13|outpost_arn|
|14|size|
|15|snapshot_id|
|16|attachments|
|17|product_codes|
|18|tags_src|
|19|title|
|20|tags|
|21|akas|
|22|partition|
|23|region|
|24|account_id|
|25|_ctx|

##  data/aws/ec2_instance_types.csv

|seq|field|
---|------|
|1|instance_type|
|2|auto_recovery_supported|
|3|bare_metal|
|4|burstable_performance_supported|
|5|current_generation|
|6|dedicated_hosts_supported|
|7|free_tier_eligible|
|8|hibernation_supported|
|9|hypervisor|
|10|instance_storage_supported|
|11|ebs_info|
|12|memory_info|
|13|network_info|
|14|placement_group_info|
|15|processor_info|
|16|supported_root_device_types|
|17|supported_usage_classes|
|18|supported_virtualization_types|
|19|v_cpu_info|
|20|gpu_info|
|21|title|
|22|akas|
|23|_ctx|

##  data/aws/ec2_instances.csv

|seq|field|
---|------|
|1|instance_id|
|2|arn|
|3|instance_type|
|4|instance_state|
|5|monitoring_state|
|6|disable_api_termination|
|7|ami_launch_index|
|8|architecture|
|9|boot_mode|
|10|capacity_reservation_id|
|11|capacity_reservation_specification|
|12|client_token|
|13|cpu_options_core_count|
|14|cpu_options_threads_per_core|
|15|ebs_optimized|
|16|ena_support|
|17|hypervisor|
|18|iam_instance_profile_arn|
|19|iam_instance_profile_id|
|20|image_id|
|21|instance_initiated_shutdown_behavior|
|22|instance_lifecycle|
|23|kernel_id|
|24|key_name|
|25|launch_time|
|26|outpost_arn|
|27|placement_availability_zone|
|28|placement_group_name|
|29|placement_tenancy|
|30|platform|
|31|platform_details|
|32|private_ip_address|
|33|private_dns_name|
|34|public_dns_name|
|35|public_ip_address|
|36|ram_disk_id|
|37|root_device_name|
|38|root_device_type|
|39|source_dest_check|
|40|sriov_net_support|
|41|state_code|
|42|state_transition_reason|
|43|state_transition_time|
|44|subnet_id|
|45|tpm_support|
|46|usage_operation|
|47|usage_operation_update_time|
|48|user_data|
|49|virtualization_type|
|50|vpc_id|
|51|block_device_mappings|
|52|elastic_gpu_associations|
|53|elastic_inference_accelerator_associations|
|54|enclave_options|
|55|hibernation_options|
|56|metadata_options|
|57|network_interfaces|
|58|private_dns_name_options|
|59|product_codes|
|60|security_groups|
|61|instance_status|
|62|tags_src|
|63|title|
|64|tags|
|65|akas|
|66|partition|
|67|region|
|68|account_id|
|69|_ctx|

##  data/aws/elasticache_clusters.csv

|seq|field|
---|------|
|1|cache_cluster_id|
|2|arn|
|3|cache_node_type|
|4|cache_cluster_status|
|5|at_rest_encryption_enabled|
|6|auth_token_enabled|
|7|auto_minor_version_upgrade|
|8|cache_cluster_create_time|
|9|cache_subnet_group_name|
|10|client_download_landing_page|
|11|configuration_endpoint|
|12|engine|
|13|engine_version|
|14|num_cache_nodes|
|15|preferred_availability_zone|
|16|preferred_maintenance_window|
|17|replication_group_id|
|18|snapshot_retention_limit|
|19|snapshot_window|
|20|transit_encryption_enabled|
|21|cache_parameter_group|
|22|notification_configuration|
|23|pending_modified_values|
|24|security_groups|
|25|tags_src|
|26|title|
|27|tags|
|28|akas|
|29|partition|
|30|region|
|31|account_id|
|32|_ctx|

##  data/aws/network_load_balancers.csv

|seq|field|
---|------|
|1|name|
|2|arn|
|3|type|
|4|scheme|
|5|canonical_hosted_zone_id|
|6|created_time|
|7|customer_owned_ipv4_pool|
|8|dns_name|
|9|ip_address_type|
|10|state_code|
|11|state_reason|
|12|vpc_id|
|13|availability_zones|
|14|security_groups|
|15|load_balancer_attributes|
|16|tags_src|
|17|tags|
|18|title|
|19|akas|
|20|partition|
|21|region|
|22|account_id|
|23|_ctx|

##  data/aws/paas_accounts.csv

|seq|field|
---|------|
|1|Name|
|2|Description|
|3|Category|
|4|AccountNumber|
|5|RoleName|
|6|RoleArn|

##  data/aws/rds_db_instances.csv

|seq|field|
---|------|
|1|db_instance_identifier|
|2|arn|
|3|db_cluster_identifier|
|4|status|
|5|class|
|6|resource_id|
|7|allocated_storage|
|8|auto_minor_version_upgrade|
|9|availability_zone|
|10|backup_retention_period|
|11|ca_certificate_identifier|
|12|character_set_name|
|13|copy_tags_to_snapshot|
|14|customer_owned_ip_enabled|
|15|port|
|16|db_name|
|17|db_subnet_group_arn|
|18|db_subnet_group_description|
|19|db_subnet_group_name|
|20|db_subnet_group_status|
|21|deletion_protection|
|22|endpoint_address|
|23|endpoint_hosted_zone_id|
|24|endpoint_port|
|25|engine|
|26|engine_version|
|27|enhanced_monitoring_resource_arn|
|28|iam_database_authentication_enabled|
|29|create_time|
|30|iops|
|31|kms_key_id|
|32|latest_restorable_time|
|33|license_model|
|34|master_user_name|
|35|max_allocated_storage|
|36|monitoring_interval|
|37|monitoring_role_arn|
|38|multi_az|
|39|nchar_character_set_name|
|40|performance_insights_enabled|
|41|performance_insights_kms_key_id|
|42|performance_insights_retention_period|
|43|preferred_backup_window|
|44|preferred_maintenance_window|
|45|promotion_tier|
|46|publicly_accessible|
|47|read_replica_source_db_instance_identifier|
|48|replica_mode|
|49|secondary_availability_zone|
|50|storage_encrypted|
|51|storage_type|
|52|tde_credential_arn|
|53|timezone|
|54|vpc_id|
|55|associated_roles|
|56|certificate|
|57|db_parameter_groups|
|58|db_security_groups|
|59|domain_memberships|
|60|enabled_cloudwatch_logs_exports|
|61|option_group_memberships|
|62|pending_maintenance_actions|
|63|processor_features|
|64|read_replica_db_cluster_identifiers|
|65|read_replica_db_instance_identifiers|
|66|status_infos|
|67|subnets|
|68|vpc_security_groups|
|69|tags_src|
|70|tags|
|71|title|
|72|akas|
|73|partition|
|74|region|
|75|account_id|
|76|_ctx|

##  data/aws/rds_db_snapshots.csv

|seq|field|
---|------|
|1|db_snapshot_identifier|
|2|arn|
|3|type|
|4|status|
|5|create_time|
|6|allocated_storage|
|7|availability_zone|
|8|db_instance_identifier|
|9|dbi_resource_id|
|10|encrypted|
|11|engine|
|12|engine_version|
|13|iam_database_authentication_enabled|
|14|instance_create_time|
|15|iops|
|16|kms_key_id|
|17|license_model|
|18|master_user_name|
|19|option_group_name|
|20|percent_progress|
|21|port|
|22|source_db_snapshot_identifier|
|23|source_region|
|24|storage_type|
|25|tde_credential_arn|
|26|timezone|
|27|vpc_id|
|28|db_snapshot_attributes|
|29|processor_features|
|30|tags_src|
|31|tags|
|32|title|
|33|akas|
|34|partition|
|35|region|
|36|account_id|
|37|_ctx|

##  data/aws/s3_buckets.csv

|seq|field|
---|------|

##  data/aws/sqs_queues.csv

|seq|field|
---|------|
|1|queue_url|
|2|queue_arn|
|3|fifo_queue|
|4|delay_seconds|
|5|max_message_size|
|6|message_retention_seconds|
|7|receive_wait_time_seconds|
|8|sqs_managed_sse_enabled|
|9|visibility_timeout_seconds|
|10|policy|
|11|policy_std|
|12|redrive_policy|
|13|content_based_deduplication|
|14|kms_master_key_id|
|15|tags|
|16|title|
|17|akas|
|18|partition|
|19|region|
|20|account_id|
|21|_ctx|

##  data/govuk_paas/apps.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|name|
|6|state|
|7|lifecycle/type|
|8|lifecycle/data/stack|
|9|relationships/space/data/guid|
|10|links/self/href|
|11|links/environment_variables/href|
|12|links/space/href|
|13|links/processes/href|
|14|links/packages/href|
|15|links/current_droplet/href|
|16|links/droplets/href|
|17|links/tasks/href|
|18|links/start/href|
|19|links/start/method|
|20|links/stop/href|
|21|links/stop/method|
|22|links/revisions/href|
|23|links/deployed_revisions/href|
|24|links/features/href|
|25|lifecycle/data/buildpacks/0|
|26|lifecycle/data/buildpacks/1|
|27|metadata/labels/prometheus.io/address|
|28|metadata/labels/owned_by|
|29|metadata/labels/last_deployed|
|30|metadata/labels/deployed_by|
|31|lifecycle/data/buildpacks/2|
|32|metadata/labels/prometheus|

##  data/govuk_paas/buildpacks.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|name|
|6|stack|
|7|state|
|8|filename|
|9|position|
|10|enabled|
|11|locked|
|12|links/self/href|
|13|links/upload/href|
|14|links/upload/method|

##  data/govuk_paas/domains.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|name|
|6|internal|
|7|router_group|
|8|supported_protocols/0|
|9|relationships/organization/data|
|10|links/self/href|
|11|links/route_reservations/href|
|12|relationships/organization/data/guid|
|13|relationships/shared_organizations/data/0/guid|
|14|links/organization/href|
|15|links/shared_organizations/href|

##  data/govuk_paas/feature_flags.csv

|seq|field|
---|------|
|1|region|
|2|name|
|3|enabled|
|4|updated_at|
|5|custom_error_message|
|6|links/self/href|

##  data/govuk_paas/isolation_segments.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|name|
|6|links/self/href|
|7|links/organizations/href|

##  data/govuk_paas/organization_quotas.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|name|
|6|apps/total_memory_in_mb|
|7|apps/per_process_memory_in_mb|
|8|apps/total_instances|
|9|apps/per_app_tasks|
|10|apps/log_rate_limit_in_bytes_per_second|
|11|services/paid_services_allowed|
|12|services/total_service_instances|
|13|services/total_service_keys|
|14|routes/total_routes|
|15|routes/total_reserved_ports|
|16|domains/total_domains|
|17|relationships/organizations/data/0/guid|
|18|relationships/organizations/data/1/guid|
|19|relationships/organizations/data/2/guid|
|20|relationships/organizations/data/3/guid|
|21|relationships/organizations/data/4/guid|
|22|relationships/organizations/data/5/guid|
|23|relationships/organizations/data/6/guid|
|24|links/self/href|

##  data/govuk_paas/organizations.csv

|seq|field|
---|------|
|1|owner|
|2|region|
|3|org_name|
|4|org_guid|
|5|quota_guid|
|6|created|
|7|suspended|

##  data/govuk_paas/processes.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|type|
|6|command|
|7|instances|
|8|memory_in_mb|
|9|disk_in_mb|
|10|log_rate_limit_in_bytes_per_second|
|11|health_check/type|
|12|health_check/data/timeout|
|13|health_check/data/invocation_timeout|
|14|relationships/app/data/guid|
|15|relationships/revision|
|16|links/self/href|
|17|links/scale/href|
|18|links/scale/method|
|19|links/app/href|
|20|links/space/href|
|21|links/stats/href|
|22|relationships/revision/data/guid|
|23|health_check/data/endpoint|

##  data/govuk_paas/routes.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|protocol|
|6|host|
|7|path|
|8|port|
|9|url|
|10|relationships/space/data/guid|
|11|relationships/domain/data/guid|
|12|links/self/href|
|13|links/space/href|
|14|links/destinations/href|
|15|links/domain/href|
|16|destinations/0/guid|
|17|destinations/0/app/guid|
|18|destinations/0/app/process/type|
|19|destinations/0/weight|
|20|destinations/0/port|
|21|destinations/0/protocol|
|22|destinations/1/guid|
|23|destinations/1/app/guid|
|24|destinations/1/app/process/type|
|25|destinations/1/weight|
|26|destinations/1/port|
|27|destinations/1/protocol|
|28|destinations/2/guid|
|29|destinations/2/app/guid|
|30|destinations/2/app/process/type|
|31|destinations/2/weight|
|32|destinations/2/port|
|33|destinations/2/protocol|

##  data/govuk_paas/security_groups.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|name|
|6|rules/0/destination|
|7|rules/0/protocol|
|8|rules/1/destination|
|9|rules/1/protocol|
|10|rules/2/destination|
|11|rules/2/protocol|
|12|rules/3/destination|
|13|rules/3/protocol|
|14|rules/4/destination|
|15|rules/4/protocol|
|16|globally_enabled/running|
|17|globally_enabled/staging|
|18|links/self/href|
|19|rules/0/ports|
|20|rules/1/ports|
|21|relationships/running_spaces/data/0/guid|

##  data/govuk_paas/service_brokers.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|name|
|6|url|
|7|links/self/href|
|8|links/service_offerings/href|
|9|relationships/space/data/guid|
|10|links/space/href|

##  data/govuk_paas/service_instances.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|name|
|6|type|
|7|syslog_drain_url|
|8|route_service_url|
|9|relationships/space/data/guid|
|10|links/self/href|
|11|links/space/href|
|12|links/service_credential_bindings/href|
|13|links/service_route_bindings/href|
|14|links/credentials/href|
|15|last_operation/type|
|16|last_operation/state|
|17|last_operation/description|
|18|last_operation/updated_at|
|19|last_operation/created_at|
|20|upgrade_available|
|21|dashboard_url|
|22|relationships/service_plan/data/guid|
|23|links/service_plan/href|
|24|links/parameters/href|
|25|links/shared_spaces/href|

##  data/govuk_paas/service_offerings.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|name|
|6|description|
|7|available|
|8|tags/0|
|9|tags/1|
|10|shareable|
|11|documentation_url|
|12|broker_catalog/id|
|13|broker_catalog/metadata/AdditionalMetadata/otherDocumentation/0|
|14|broker_catalog/metadata/AdditionalMetadata/otherDocumentation/1|
|15|broker_catalog/metadata/displayName|
|16|broker_catalog/metadata/documentationUrl|
|17|broker_catalog/metadata/longDescription|
|18|broker_catalog/metadata/providerDisplayName|
|19|broker_catalog/metadata/shareable|
|20|broker_catalog/metadata/supportUrl|
|21|broker_catalog/features/plan_updateable|
|22|broker_catalog/features/bindable|
|23|broker_catalog/features/instances_retrievable|
|24|broker_catalog/features/bindings_retrievable|
|25|broker_catalog/features/allow_context_updates|
|26|relationships/service_broker/data/guid|
|27|links/self/href|
|28|links/service_plans/href|
|29|links/service_broker/href|
|30|broker_catalog/metadata/AdditionalMetadata/usecase/0|
|31|broker_catalog/metadata/AdditionalMetadata/usecase/1|
|32|broker_catalog/metadata/AdditionalMetadata/usecase/2|
|33|requires/0|
|34|broker_catalog/metadata/imageUrl|
|35|tags/2|
|36|tags/3|
|37|tags/4|

##  data/govuk_paas/service_plans.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|name|
|6|visibility_type|
|7|available|
|8|free|
|9|description|
|10|broker_catalog/id|
|11|broker_catalog/metadata/AdditionalMetadata/highlyAvailable|
|12|broker_catalog/metadata/AdditionalMetadata/version|
|13|broker_catalog/metadata/displayName|
|14|broker_catalog/maximum_polling_duration|
|15|broker_catalog/features/bindable|
|16|broker_catalog/features/plan_updateable|
|17|relationships/service_offering/data/guid|
|18|links/self/href|
|19|links/service_offering/href|
|20|links/visibility/href|
|21|broker_catalog/metadata/AdditionalMetadata/backups|
|22|broker_catalog/metadata/AdditionalMetadata/encrypted|
|23|broker_catalog/metadata/AdditionalMetadata/instanceClass|
|24|broker_catalog/metadata/AdditionalMetadata/storage/amount|
|25|broker_catalog/metadata/AdditionalMetadata/storage/unit|
|26|broker_catalog/metadata/bullets/0|
|27|broker_catalog/metadata/bullets/1|
|28|broker_catalog/metadata/bullets/2|
|29|broker_catalog/metadata/AdditionalMetadata/memory/amount|
|30|broker_catalog/metadata/AdditionalMetadata/memory/unit|
|31|relationships/space/data/guid|
|32|links/space/href|
|33|broker_catalog/metadata/AdditionalMetadata/concurrentConnections|
|34|broker_catalog/metadata/AdditionalMetadata/cpu|
|35|broker_catalog/metadata/AdditionalMetadata/nodes|
|36|broker_catalog/metadata/AdditionalMetadata/highIOPS|

##  data/govuk_paas/service_route_bindings.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|route_service_url|
|4|created_at|
|5|updated_at|
|6|last_operation/type|
|7|last_operation/state|
|8|last_operation/description|
|9|last_operation/created_at|
|10|last_operation/updated_at|
|11|relationships/service_instance/data/guid|
|12|relationships/route/data/guid|
|13|links/self/href|
|14|links/service_instance/href|
|15|links/route/href|

##  data/govuk_paas/space_quotas.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|name|
|6|apps/total_memory_in_mb|
|7|apps/per_process_memory_in_mb|
|8|apps/total_instances|
|9|apps/per_app_tasks|
|10|apps/log_rate_limit_in_bytes_per_second|
|11|services/paid_services_allowed|
|12|services/total_service_instances|
|13|services/total_service_keys|
|14|routes/total_routes|
|15|routes/total_reserved_ports|
|16|relationships/organization/data/guid|
|17|links/self/href|
|18|links/organization/href|
|19|relationships/spaces/data/0/guid|

##  data/govuk_paas/spaces.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|name|
|6|relationships/organization/data/guid|
|7|relationships/quota/data|
|8|links/self/href|
|9|links/organization/href|
|10|links/features/href|
|11|links/apply_manifest/href|
|12|links/apply_manifest/method|
|13|relationships/quota/data/guid|
|14|links/quota/href|
|15|metadata/labels/available|

##  data/govuk_paas/stacks.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|name|
|6|description|
|7|links/self/href|

##  data/govuk_paas/users.csv

|seq|field|
---|------|
|1|region|
|2|guid|
|3|created_at|
|4|updated_at|
|5|username|
|6|presentation_name|
|7|origin|
|8|links/self/href|

##  data/govuk_paas/virtual_machines.csv

|seq|field|
---|------|
|1|environment|
|2|region|
|3|vm_type|
|4|vm_count|

##  data/holidays.csv

|seq|field|
---|------|
|1|title|
|2|date|
|3|notes|
|4|bunting|

##  data/settings.csv

|seq|field|
---|------|
|1|key|
|2|value|

