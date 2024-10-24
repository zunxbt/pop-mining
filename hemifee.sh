#!/bin/bash

show() {
    echo -e "\033[1;35m$1\033[0m"
}

restart_service() {
    local service_name="hemi.service"
    local attempts=0
    local max_attempts=10

    while (( attempts < max_attempts )); do
        sudo systemctl restart "$service_name"
        if systemctl is-active --quiet "$service_name"; then
            show "$service_name restarted successfully."
            return 0
        else
            attempts=$((attempts + 1))
            show "Failed to restart $service_name (Attempt $attempts/$max_attempts). Retrying in 5 seconds..."
            sleep 15
        fi
    done

    show "Failed to restart $service_name after $max_attempts attempts."
    return 1
}

fetch_and_update_fee() {
    local service_name="hemi.service"
    local service_file="/etc/systemd/system/$service_name"

    while true; do
        raw_fee=$(curl -sSL "https://mempool.space/testnet/api/v1/fees/mempool-blocks" | jq '.[0].medianFee')

        if [[ ! -z "$raw_fee" ]]; then
            static_fee=$(printf "%.0f" "$raw_fee")
            show "Static fee fetched: $static_fee"

            if [[ -f "$service_file" ]]; then
                if systemctl is-active --quiet "$service_name"; then
                    show "Stopping $service_name..."
                    sudo systemctl stop "$service_name"
                fi

                show "Updating static fee in $service_file"
                sudo sed -i '/POPM_STATIC_FEE/d' "$service_file"
                sudo sed -i "/\[Service\]/a Environment=\"POPM_STATIC_FEE=$static_fee\"" "$service_file"
                
                sudo systemctl daemon-reload
                show "Waiting 15 seconds before restarting the service..."
                sleep 15

                restart_service "$service_name"
            fi

            sleep 600
        else
            show "Failed to fetch static fee. Retrying in 15 seconds."
            sleep 15
            continue
        fi
    done
}

fetch_and_update_fee &
