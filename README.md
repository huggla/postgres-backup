**Note! I use Docker latest tag for development, which means that it isn't allways working. Date tags are stable.**

# postgres-backup
A tiny and simple Docker image for backing up Postgresql.

## Environment variables
### pre-set runtime variables
* VAR_LINUX_USER (postgres): The Linux/Postgresql user that performs the backup.
* VAR_FINAL_COMMAND (/usr/sbin/crond -f -d 8): Backups are initiated by crond.
* VAR_BACKUP_DIR (/backup): Where the backups will be created.
* VAR_PORT (5432): Database port.
* VAR_FORMAT (directory): Pg_dump format.
* VAR_JOBS (1): Number of parallel backup jobs. Only used if VAR_FORMAT="directory".
* VAR_COMPRESS (6): 0 is no compression, 9 is max compression. For directory and plain formats only.
* VAR_DUMP_GLOBALS (yes): Dump all postgres globals in a separate file.
* VAR_DELETE_DUPLICATES (yes): Duplicate files will be deleted from previous backup.

### Other runtime variables
* VAR_HOST: The database host.
* VAR_DATABASES: Comma separated list of databases to back up.
* VAR_&lt;database from VAR_DATABASES&gt;_format: Like VAR_FORMAT, but limited to named database.
* VAR_&lt;database from VAR_DATABASES&gt;_jobs: Like VAR_JOBS, but limited to named database.
* VAR_CLEAN: Set to "yes" to add cleaning commands to the backup.
* VAR_&lt;database from VAR_DATABASES&gt;_clean: Like VAR_CLEAN, but limited to named database.
* VAR_SCHEMA_ONLY: Set to "yes" to only dump schemas.
* VAR_&lt;database from VAR_DATABASES&gt;_excludeschemas: Schemas in named database that should not be backed up.
* VAR_&lt;database from VAR_DATABASES&gt;_schemas: Limit back up to these schemas in named database.
* VAR_&lt;database from VAR_DATABASES&gt;_excludetables: Tables in named database that should not be backed up.
* VAR_&lt;database from VAR_DATABASES&gt;_tables: Limit back up to these tables in named database.
* VAR_BLOBS: Set to "no" to not back up data blobs.
* VAR_&lt;name&gt;: Name of backup cron job.
* VAR_cron_&lt;name&gt;: When to run backups of named job.

## Cron examples
>VAR_weekdays="/bin/date +%a"  
VAR_cron_weekdays="0 21 \* \* 1-5"

>VAR_weekly="(( $(/bin/date +%d) + 6 ) / 7)"  
VAR_cron_weekly="0 19 \* \* 5"

>VAR_monthly="/bin/date +%b"  
VAR_cron_monthly="0 17 1 * *"

## Capabilities
Can drop all but CHOWN, FOWNER, SETGID and SETUID.
