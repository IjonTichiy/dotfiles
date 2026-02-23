# ~/.config/python/pythonstartup.py
# Redirect Python interactive REPL history to ~/.cache/python/history
# Referenced via PYTHONSTARTUP env var in .bashrc

import atexit
import os
import sys
from pathlib import Path

try:
    import readline
except ImportError:
    pass
else:
    # Tab completion
    readline.parse_and_bind("tab: complete")

    # Disable the default history hook (writes to ~/.python_history)
    if hasattr(sys, "__interactivehook__"):
        del sys.__interactivehook__

    # Point history at our cache directory
    cache = Path(os.getenv("XDG_CACHE_HOME", Path.home() / ".cache"))
    histfile = cache / "python" / "history"
    histfile.parent.mkdir(parents=True, exist_ok=True)
    histfile.touch(exist_ok=True)

    readline.read_history_file(histfile)
    readline.set_history_length(5000)
    atexit.register(readline.write_history_file, histfile)
