#!/bin/bash

# This is a shell script that you can use to clean elodie import and stage folders

# directoies
IMPORT_DIR="/srv/dev-disk-by-uuid-2cd1750d-f2a8-4717-abc8-77fe2da9eaf3/home/Photos_import"
STAGE_DIR="/srv/dev-disk-by-uuid-2cd1750d-f2a8-4717-abc8-77fe2da9eaf3/home/Photos_staged"

# clean import
rm -rf $IMPORT_DIR/.Trash-1000
rm -rf $IMPORT_DIR/*

# clean stage
rm -rf $STAGE_DIR/.Trash-1000
rm -rf $STAGE_DIR/*

