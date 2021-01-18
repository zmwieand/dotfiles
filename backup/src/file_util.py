import os
import tarfile

import gnupg

def tar_file(filename, file_paths):
    """
    Create a tar.gz archive for a list of file_paths.
    """
    with tarfile.open(filename, 'w:gz') as tar:
        for path in file_paths:
            tar.add(os.path.expanduser(path))

def encrypt_file(filename, filepath, recipients):
    """
    Create an encrypted gpg file for a filepath.
    """
    gpg = gnupg.GPG(gpgbinary='/usr/local/bin/gpg')
    filename = os.path.expanduser(filename)
    with open(filepath, 'rb') as tar:
        gpg.encrypt_file(
            tar,
            output=filename,
            recipients=recipients
        )

def file_exists(path):
    """
    Verify a file by path exists.
    """
    path = os.path.expanduser(path)
    if os.path.exists(path):
        return True
    else:
        print(f'Path: {path} not found. Skipping...')
        return False

def cleanup_file(filename):
    """
    Remove a file by filename.
    """
    path = os.path.expanduser(filename)
    os.remove(path)

def get_backups(mount_path, machineName):
    """
    Returns a list of backup filepaths for the current user and machine name
    """
    mount_path = os.path.expanduser(f'{mount_path}/Backups/{machineName}/')
    paths = os.listdir(mount_path)
    return paths
