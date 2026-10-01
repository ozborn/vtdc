#!/usr/bin/env python3
"""Fetch one checksum-locked artifact; needs only the Python standard library."""
import hashlib
import json
import os
from pathlib import Path
import sys
import tempfile
import urllib.request


def digest(path):
    with path.open("rb") as stream:
        return hashlib.file_digest(stream, "sha256").hexdigest()


def main():
    lock = json.loads(Path(sys.argv[1]).read_text())
    target = Path(sys.argv[2])
    if target.exists() and digest(target) == lock["sha256"]:
        return
    target.parent.mkdir(parents=True, exist_ok=True)
    temporary = None
    try:
        with tempfile.NamedTemporaryFile(dir=target.parent, delete=False) as stream:
            temporary = Path(stream.name)
            with urllib.request.urlopen(lock["url"], timeout=120) as response:
                while chunk := response.read(1024 * 1024):
                    stream.write(chunk)
        if digest(temporary) != lock["sha256"]:
            raise SystemExit(f"Checksum mismatch for {lock['url']}")
        os.replace(temporary, target)
        print(f"Installed {target}")
    finally:
        if temporary is not None:
            temporary.unlink(missing_ok=True)


if __name__ == "__main__":
    main()
