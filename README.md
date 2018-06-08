**Note! I use Docker latest tag for development, which means that it isn't allways working. Date tags are stable.**

# postgres-backup
A tiny and simple Docker image for backing up Postgresql.

## Environment variables
### pre-set runtime variables
* VAR_LINUX_USER (postgres): The Linux/Postgresql user that performs the backup.
* VAR_FINAL_COMMAND (/usr/sbin/crond -f -d 8): Backups are initiated by crond.
* VAR_BACKUP_DIR (/pgbackup): Where the backups will be created.
* VAR_PORT (5432): Database port.
* VAR_FORMAT (directory): Pg_dump format.
* VAR_JOBS (1): Number of parallel backup jobs. Only used if VAR_FORMAT="directory".
* VAR_COMPRESS (6): 0 is no compression, 9 is max compression.
* VAR_DUMP_GLOBALS (yes): Dump all postgres globals in a separate file.
* VAR_DELETE_DUPLICATES (yes): Duplicate files will be deleted from previous backup.

### Other runtime variables
* VAR_HOST: The database host.
* VAR_DATABASES: Comma separated list of databases to back up.
* VAR_&lt;database from VAR_DATABASES&gt;_format: Like VAR_FORMAT, but limited to named database.
* VAR_&lt;database from VAR_DATABASES&gt;_jobs: Like VAR_JOBS, but limited to named database.
* VAR_AUTH_HBA: Comma separated list of hba rules. Optional.
* VAR_param_&lt;parameter name&gt;: f ex VAR_param_auth_type.
* VAR_password&#95;file_&lt;user name from VAR_DATABASE_USERS&gt;: Path to file containing the password for named user.
* VAR_password_&lt;user name from VAR_DATABASE_USERS&gt;: The password for named user. Slightly less secure.
* VAR_ENCRYPT_PW: Set to "yes" to hash passwords with Argon2.

## Capabilities
Can drop all but CHOWN, DAC_OVERRIDE, FOWNER, SETGID and SETUID.
