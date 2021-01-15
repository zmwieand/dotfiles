from datetime import date, timedelta
import os.path

import yaml

from src.date_util import get_retention_dates
from src.file_util import cleanup_file, encrypt_file, file_exists, get_backups, tar_file

def main():
    # Read input yaml and parse into settings
    config_path = os.path.expanduser('~/.backuprc')
    with open(config_path, 'r') as config:
        config = yaml.load(config, Loader=yaml.Loader)

    user = config['nas']['user']
    machineName = config['nas']['machineName']
    nas_mount = config['nas']['mountLocation']
    paths = config['paths']
    recipients = [config['gpg']['recipient']]

    # TODO: should probably fail if these do not get parsed out correctly

    # Verify all paths exist
    paths = list(filter(lambda p: file_exists(p), paths))

    today = date.today()
    tar_filename = today.strftime('/tmp/%Y-%m-%d-backup.tar.gz')
    gpg_filename = today.strftime(f'{nas_mount}/Backups/{machineName}/%Y-%m-%d-backup.gpg')

    # Create and encrypt tgz
    tar_file(tar_filename, paths)
    encrypt_file(gpg_filename, tar_filename, recipients)

    # Format retainment dates to filenames
    retain = get_retention_dates(today)
    retain = list(map(lambda d: d.strftime('%Y-%m-%d-backup.gpg'), retain))

    # Purge any backup files that are not in retainment dates
    current_backups = get_backups(nas_mount, machineName)
    for backup in current_backups:
        if backup not in retain:
            print(f'Removing backup: {backup}')
            cleanup_file(f'{nas_mount}/Backups/{machineName}/{backup}')

    # Cleanup newly created backup files on the local machine (/tmp)
    cleanup_file(tar_filename)

if __name__ == '__main__':
    main()
