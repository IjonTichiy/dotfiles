"""
Global YCM extra configuration.

This file provides sane defaults for YouCompleteMe when no project-local
.ycm_extra_conf.py is found. It handles:

  1. C/C++ projects: uses compile_commands.json if found, else falls back
     to reasonable default flags.
  2. Python projects: detects virtualenvs and uses the correct interpreter.
  3. WSL path handling: filters out Windows-style paths that confuse clangd.

For per-project overrides, drop a .ycm_extra_conf.py in the project root.
"""

import os
import subprocess

# ---------------------------------------------------------------------------
# C/C++ defaults (used when no compilation database is found)
# ---------------------------------------------------------------------------
DEFAULT_FLAGS = [
    '-Wall',
    '-Wextra',
    '-Werror',
    '-std=c++17',
    '-x', 'c++',
    '-isystem', '/usr/include',
    '-isystem', '/usr/local/include',
    '-isystem', '/usr/include/c++/11',
    '-isystem', '/usr/include/c++/12',
    '-isystem', '/usr/include/c++/13',
    '-I', '.',
    '-I', './include',
    '-I', './src',
]

# Paths that should never be passed to clangd (WSL/Windows noise)
WSL_PATH_PREFIXES = ('/mnt/c/', '/mnt/d/', 'C:\\', 'D:\\')


def _is_wsl_path(path):
    """Return True if path points to a Windows filesystem via WSL mount."""
    return any(path.startswith(p) for p in WSL_PATH_PREFIXES)


def _filter_wsl_paths(flags):
    """Remove -I/-isystem entries that point to Windows filesystems.

    These cause clangd to crawl NTFS via the 9P bridge, which is extremely
    slow and produces incorrect results anyway.
    """
    filtered = []
    skip_next = False
    for i, flag in enumerate(flags):
        if skip_next:
            skip_next = False
            continue
        if flag in ('-I', '-isystem', '-iquote', '--sysroot'):
            # Next arg is the path
            if i + 1 < len(flags) and _is_wsl_path(flags[i + 1]):
                skip_next = True
                continue
        if flag.startswith(('-I/', '-isystem/')) and _is_wsl_path(flag.split('/', 1)[-1]):
            continue
        filtered.append(flag)
    return filtered


def _find_compilation_database(filename):
    """Walk up from the file's directory looking for compile_commands.json.

    Checks common build directory names at each level.
    """
    directory = os.path.dirname(os.path.abspath(filename))
    build_dirs = ['build', 'cmake-build-debug', 'cmake-build-release', 'out', '.']

    for _ in range(20):  # max depth
        for bd in build_dirs:
            candidate = os.path.join(directory, bd, 'compile_commands.json')
            if os.path.isfile(candidate):
                return os.path.join(directory, bd)
        parent = os.path.dirname(directory)
        if parent == directory:
            break
        directory = parent
    return None


def _get_python_path():
    """Return the active Python interpreter (virtualenv-aware)."""
    venv = os.environ.get('VIRTUAL_ENV')
    if venv:
        candidate = os.path.join(venv, 'bin', 'python3')
        if os.path.isfile(candidate):
            return candidate
    return '/usr/bin/python3'


def Settings(**kwargs):
    """Entry point called by YCM for every file."""
    language = kwargs.get('language', '')

    # ------------------------------------------------------------------
    # Python
    # ------------------------------------------------------------------
    if language == 'python':
        return {
            'interpreter_path': _get_python_path(),
        }

    # ------------------------------------------------------------------
    # C-family
    # ------------------------------------------------------------------
    filename = kwargs.get('filename', '')

    # Try compilation database first (cmake, bear, etc.)
    db_dir = _find_compilation_database(filename)
    if db_dir:
        return {
            'flags': _filter_wsl_paths(DEFAULT_FLAGS),
            'include_paths_relative_to_dir': db_dir,
            'override_filename': filename,
        }

    # Fall back to default flags
    # Make -I paths relative to the file's directory
    project_dir = os.path.dirname(os.path.abspath(filename))
    flags = list(DEFAULT_FLAGS)

    # Add project-local include if it exists
    local_inc = os.path.join(project_dir, 'include')
    if os.path.isdir(local_inc):
        flags.extend(['-I', local_inc])

    return {
        'flags': _filter_wsl_paths(flags),
        'include_paths_relative_to_dir': project_dir,
    }
