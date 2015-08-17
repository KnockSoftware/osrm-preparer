if [[ -z "$AWS_ACCESS_KEY_ID" || -z "$AWS_SECRET_ACCESS_KEY" || -z "AWS_DEFAULT_REGION" ]]; then
  echo "Need AWS credentials in environment"
  exit 1
fi

exec docker run \
  -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
  -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" \
  -e "AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION" \
  -e "OSM_PBF_URL=http://download.geofabrik.de/north-america-latest.osm.pbf" \
  -e "AWS_DESTINATION=s3://osrm-prepared-data/north-america.osrm.tar.gz" \
  "$@"
