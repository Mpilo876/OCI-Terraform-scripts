#WAF

resource "oci_waf_network_address_list" "test_network_address_list" {
    #Required
    compartment_id = var.compartment_id
    type = var.network_address_list_type

    #Optional
    addresses = var.network_address_list_addresses
    defined_tags = {"foo-namespace.bar-key"= "value"}
    display_name = var.network_address_list_display_name
    freeform_tags = {"bar-key"= "value"}
    system_tags = var.network_address_list_system_tags
    vcn_addresses {

        #Optional
        addresses = var.network_address_list_vcn_addresses_addresses
        vcn_id = oci_core_vcn.test_vcn.id
    }
}

resource "oci_waf_web_app_firewall" "test_web_app_firewall" {
    #Required
    backend_type = var.web_app_firewall_backend_type
    compartment_id = var.compartment_id
    load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id
    web_app_firewall_policy_id = oci_waf_web_app_firewall_policy.test_web_app_firewall_policy.id

    #Optional
    defined_tags = {"foo-namespace.bar-key"= "value"}
    display_name = var.web_app_firewall_display_name
    freeform_tags = {"bar-key"= "value"}
    system_tags = var.web_app_firewall_system_tags
}




#WAF policy
resource "oci_waf_web_app_firewall_policy" "test_web_app_firewall_policy" {
    #Required
    compartment_id = var.compartment_id

    #Optional
    actions {
        #Required
        name = var.web_app_firewall_policy_actions_name
        type = var.web_app_firewall_policy_actions_type

        #Optional
        body {
            #Required
            text = var.web_app_firewall_policy_actions_body_text
            type = var.web_app_firewall_policy_actions_body_type
        }
        code = var.web_app_firewall_policy_actions_code
        headers {

            #Optional
            name = var.web_app_firewall_policy_actions_headers_name
            value = var.web_app_firewall_policy_actions_headers_value
        }
    }
    defined_tags = {"foo-namespace.bar-key"= "value"}
    display_name = var.web_app_firewall_policy_display_name
    freeform_tags = {"bar-key"= "value"}
    request_access_control {
        #Required
        default_action_name = var.web_app_firewall_policy_request_access_control_default_action_name

        #Optional
        rules {
            #Required
            action_name = var.web_app_firewall_policy_request_access_control_rules_action_name
            name = var.web_app_firewall_policy_request_access_control_rules_name
            type = var.web_app_firewall_policy_request_access_control_rules_type

            #Optional
            condition = var.web_app_firewall_policy_request_access_control_rules_condition
            condition_language = var.web_app_firewall_policy_request_access_control_rules_condition_language
        }
    }
    request_protection {

        #Optional
        body_inspection_size_limit_exceeded_action_name = var.web_app_firewall_policy_request_protection_body_inspection_size_limit_exceeded_action_name
        body_inspection_size_limit_in_bytes = var.web_app_firewall_policy_request_protection_body_inspection_size_limit_in_bytes
        rules {
            #Required
            action_name = var.web_app_firewall_policy_request_protection_rules_action_name
            name = var.web_app_firewall_policy_request_protection_rules_name
            protection_capabilities {
                #Required
                key = var.web_app_firewall_policy_request_protection_rules_protection_capabilities_key
                version = var.web_app_firewall_policy_request_protection_rules_protection_capabilities_version

                #Optional
                action_name = var.web_app_firewall_policy_request_protection_rules_protection_capabilities_action_name
                collaborative_action_threshold = var.web_app_firewall_policy_request_protection_rules_protection_capabilities_collaborative_action_threshold
                collaborative_weights {
                    #Required
                    key = var.web_app_firewall_policy_request_protection_rules_protection_capabilities_collaborative_weights_key
                    weight = var.web_app_firewall_policy_request_protection_rules_protection_capabilities_collaborative_weights_weight
                }
                exclusions {

                    #Optional
                    args = var.web_app_firewall_policy_request_protection_rules_protection_capabilities_exclusions_args
                    request_cookies = var.web_app_firewall_policy_request_protection_rules_protection_capabilities_exclusions_request_cookies
                }
            }
            type = var.web_app_firewall_policy_request_protection_rules_type

            #Optional
            condition = var.web_app_firewall_policy_request_protection_rules_condition
            condition_language = var.web_app_firewall_policy_request_protection_rules_condition_language
            is_body_inspection_enabled = var.web_app_firewall_policy_request_protection_rules_is_body_inspection_enabled
            protection_capability_settings {

                #Optional
                allowed_http_methods = var.web_app_firewall_policy_request_protection_rules_protection_capability_settings_allowed_http_methods
                max_http_request_header_length = var.web_app_firewall_policy_request_protection_rules_protection_capability_settings_max_http_request_header_length
                max_http_request_headers = var.web_app_firewall_policy_request_protection_rules_protection_capability_settings_max_http_request_headers
                max_number_of_arguments = var.web_app_firewall_policy_request_protection_rules_protection_capability_settings_max_number_of_arguments
                max_single_argument_length = var.web_app_firewall_policy_request_protection_rules_protection_capability_settings_max_single_argument_length
                max_total_argument_length = var.web_app_firewall_policy_request_protection_rules_protection_capability_settings_max_total_argument_length
            }
        }
    }
    request_rate_limiting {

        #Optional
        rules {
            #Required
            action_name = var.web_app_firewall_policy_request_rate_limiting_rules_action_name
            configurations {
                #Required
                period_in_seconds = var.web_app_firewall_policy_request_rate_limiting_rules_configurations_period_in_seconds
                requests_limit = var.web_app_firewall_policy_request_rate_limiting_rules_configurations_requests_limit

                #Optional
                action_duration_in_seconds = var.web_app_firewall_policy_request_rate_limiting_rules_configurations_action_duration_in_seconds
            }
            name = var.web_app_firewall_policy_request_rate_limiting_rules_name
            type = var.web_app_firewall_policy_request_rate_limiting_rules_type

            #Optional
            condition = var.web_app_firewall_policy_request_rate_limiting_rules_condition
            condition_language = var.web_app_firewall_policy_request_rate_limiting_rules_condition_language
        }
    }
    response_access_control {

        #Optional
        rules {
            #Required
            action_name = var.web_app_firewall_policy_response_access_control_rules_action_name
            name = var.web_app_firewall_policy_response_access_control_rules_name
            type = var.web_app_firewall_policy_response_access_control_rules_type

            #Optional
            condition = var.web_app_firewall_policy_response_access_control_rules_condition
            condition_language = var.web_app_firewall_policy_response_access_control_rules_condition_language
        }
    }
    response_protection {

        #Optional
        rules {
            #Required
            action_name = var.web_app_firewall_policy_response_protection_rules_action_name
            name = var.web_app_firewall_policy_response_protection_rules_name
            protection_capabilities {
                #Required
                key = var.web_app_firewall_policy_response_protection_rules_protection_capabilities_key
                version = var.web_app_firewall_policy_response_protection_rules_protection_capabilities_version

                #Optional
                action_name = var.web_app_firewall_policy_response_protection_rules_protection_capabilities_action_name
                collaborative_action_threshold = var.web_app_firewall_policy_response_protection_rules_protection_capabilities_collaborative_action_threshold
                collaborative_weights {
                    #Required
                    key = var.web_app_firewall_policy_response_protection_rules_protection_capabilities_collaborative_weights_key
                    weight = var.web_app_firewall_policy_response_protection_rules_protection_capabilities_collaborative_weights_weight
                }
                exclusions {

                    #Optional
                    args = var.web_app_firewall_policy_response_protection_rules_protection_capabilities_exclusions_args
                    request_cookies = var.web_app_firewall_policy_response_protection_rules_protection_capabilities_exclusions_request_cookies
                }
            }
            type = var.web_app_firewall_policy_response_protection_rules_type

            #Optional
            condition = var.web_app_firewall_policy_response_protection_rules_condition
            condition_language = var.web_app_firewall_policy_response_protection_rules_condition_language
            is_body_inspection_enabled = var.web_app_firewall_policy_response_protection_rules_is_body_inspection_enabled
            protection_capability_settings {

                #Optional
                allowed_http_methods = var.web_app_firewall_policy_response_protection_rules_protection_capability_settings_allowed_http_methods
                max_http_request_header_length = var.web_app_firewall_policy_response_protection_rules_protection_capability_settings_max_http_request_header_length
                max_http_request_headers = var.web_app_firewall_policy_response_protection_rules_protection_capability_settings_max_http_request_headers
                max_number_of_arguments = var.web_app_firewall_policy_response_protection_rules_protection_capability_settings_max_number_of_arguments
                max_single_argument_length = var.web_app_firewall_policy_response_protection_rules_protection_capability_settings_max_single_argument_length
                max_total_argument_length = var.web_app_firewall_policy_response_protection_rules_protection_capability_settings_max_total_argument_length
            }
        }
    }
    system_tags = var.web_app_firewall_policy_system_tags
}