#!/usr/bin/env python3
"""Reject malformed dates and accidental replacement of staged releases."""
from datetime import date
from pathlib import Path
import re
import sys

value = sys.argv[1]
if not re.fullmatch(r"\d{4}-\d{2}-\d{2}", value):
    raise SystemExit("Set RELEASE_DATE=YYYY-MM-DD.")
date.fromisoformat(value)
if (Path("releases") / value).exists():
    raise SystemExit(f"releases/{value} already exists; choose a new date or review it manually.")
