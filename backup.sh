set -o pipefail

if [ "${S3_ACCESS_KEY_ID}" = "**None**" ]; then
  echo "You need to set the S3_ACCESS_KEY_ID environment variable."
fi

if [ "${S3_SECRET_ACCESS_KEY}" = "**None**" ]; then
  echo "You need to set the S3_SECRET_ACCESS_KEY environment variable."
fi

if [ "${S3_BUCKET}" = "**None**" ]; then
  echo "You need to set the S3_BUCKET environment variable."
fi

# env vars needed for aws tools
export AWS_ACCESS_KEY_ID=$S3_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$S3_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=$S3_REGION

tar -cvf geoserver_conf_backup.tar /opt/geoserver/data_dir

echo "Uploading dump to $S3_BUCKET"
old=$(aws s3 ls s3://$S3_BUCKET | wc -l)
aws $AWS_ARGS s3 cp geoserver_conf_backup.tar s3://$S3_BUCKET/geoserver_conf_backup_$(date +"%Y-%m-%dT%H:%M:%SZ").tar || exit 2
new=$(aws s3 ls s3://$S3_BUCKET | wc -l)
rm -rf geoserver_conf_backup.tar

if [ $(($old+1)) == $new ]
then
  echo "geoserver config backup uploaded successfully"
else
  echo "failed to upload geoserver config backup"
fi
