#!/bin/bash

if [ ! -e /data/data.osm.pbf ]; then
  echo "$OSM_PBF_URL" > /data/data.osrm.srcurl
  curl "$OSM_PBF_URL" > /data/data.osm.pbf
fi
if [ ! -e /data/data.osrm ]; then
  ./osrm-extract /data/data.osm.pbf
fi
if [ ! -e /data/data.osrm.hsgr ]; then
  ./osrm-prepare /data/data.osrm
fi

GZIP=`which pigz`

if [ -z "$GZIP" ]; then
  GZIP=`which gzip`
fi

cd /data

tar cv data.osrm.srcurl data.osrm.timestamp data.osrm.names data.osrm.nodes data.osrm.edges data.osrm.geometry data.osrm.hsgr data.osrm.ramIndex data.osrm.fileIndex | "$GZIP" | aws s3 cp - "$AWS_DESTINATION"
