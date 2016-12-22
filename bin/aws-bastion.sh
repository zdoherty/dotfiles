#!/bin/bash
set -e

if [[ $# != 1 ]]; then
    echo "usage: $0 <login|logout>"
    exit 1
fi

profile="bastion"
section="sts"

command="$1"
case $command in
    login)

    eval $(cat $HOME/.aws/keys.gpg)
    aws configure set profile.$profile.aws_access_key_id $BASTION_AWS_ACCESS_KEY_ID
    aws configure set profile.$profile.aws_secret_access_key $BASTION_AWS_SECRET_ACCESS_KEY
    unset BASTION_AWS_ACCESS_KEY_ID
    unset BASTION_AWS_SECRET_ACCESS_KEY

    echo -n "Token: "
    read -s token

    output=$(aws --profile $profile sts get-session-token --serial-number $(aws configure get $profile.mfa_serial) --token-code $token)

    access_key=$(echo "$output" | jq -r .Credentials.AccessKeyId)
    secret_access_key=$(echo "$output" | jq -r .Credentials.SecretAccessKey)
    session_token=$(echo "$output" | jq -r .Credentials.SessionToken)

    aws configure set profile.$section.aws_access_key_id $access_key
    aws configure set profile.$section.aws_secret_access_key $secret_access_key
    aws configure set profile.$section.aws_session_token $session_token
    ;;

    logout)
    aws configure set profile.$profile.aws_access_key_id blank
    aws configure set profile.$profile.aws_secret_access_key blank
    aws configure set profile.$section.aws_access_key_id blank
    aws configure set profile.$section.aws_secret_access_key blank
    aws configure set profile.$section.aws_session_token blank
    rm -f "$HOME/.aws/cli/cache/"*
    ;;

    *)
    echo "choose 'login' or 'logout'"
    exit 1
    ;;
esac

