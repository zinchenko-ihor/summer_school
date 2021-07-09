#!/bin/bash

echo "Backup started"

# The time of creating a dump
current_date=$(date +"%Y_%m_%d_%H:%M:%S")

# Create a directory where we will save the dump
mkdir ./db_dumps

cd /home/ubuntu/db_dumps

# create a dump
mysqldump -u moodleuser -p moodle > ~/db_dumps/moodle_$current_date.sql

echo "Backup finished"
