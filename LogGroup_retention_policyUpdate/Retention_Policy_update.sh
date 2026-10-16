#!/bin/bash

RETENTION_DAYS=30
REGIONS=("us-east-1" "eu-west-1" "us-west-2")

for REGION in "${REGIONS[@]}"; do

    echo ""
    echo "=================================================="
    echo "Processing Region: $REGION"
    echo "=================================================="

    # Step 1: Find log groups without retention policies
    LOG_GROUPS=$(aws logs describe-log-groups \
        --region "$REGION" \
        --query 'logGroups[?!retentionInDays].logGroupName' \
        --output text \
        --no-cli-pager) || {
            echo "ERROR: Failed to retrieve log groups in $REGION"
            continue
        }

    echo ""
    echo "STEP 1: Checking log groups without retention policies"

    if [ -z "$LOG_GROUPS" ] || [ "$LOG_GROUPS" = "None" ]; then
        echo "No log groups without retention policies found."
    else

        printf '%s\n' "$LOG_GROUPS" | tr '\t' '\n'

        # Step 2: Apply 30-day retention policy
        echo ""
        echo "STEP 2: Applying 30-day retention policy"

        while IFS= read -r LOG_GROUP; do

            [ -z "$LOG_GROUP" ] && continue

            echo "Processing: $LOG_GROUP"

            if aws logs put-retention-policy \
                --region "$REGION" \
                --log-group-name "$LOG_GROUP" \
                --retention-in-days "$RETENTION_DAYS" \
                --no-cli-pager; then

                echo "SUCCESS: Retention policy applied to $LOG_GROUP"

            else
                echo "FAILED: Unable to update $LOG_GROUP"
            fi

        done < <(printf '%s\n' "$LOG_GROUPS" | tr '\t' '\n')

    fi

    # Step 3: Verify retention policies
    echo ""
    echo "STEP 3: Verifying retention policies in $REGION"

    aws logs describe-log-groups \
        --region "$REGION" \
        --query 'logGroups[*].[logGroupName,retentionInDays]' \
        --output table \
        --no-cli-pager

    if [ $? -ne 0 ]; then
        echo "WARNING: Verification failed in $REGION"
    fi

done

echo ""
echo "=================================================="
echo "Retention policy update process completed."
echo "=================================================="