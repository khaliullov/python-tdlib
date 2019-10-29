# python-tdlib

Python Docker image with prebuild TDLib for writing Telegram clients.

Usage (with [Pytglib](https://github.com/iTeam-co/python-telegram)):

    from pytglib.client import Telegram
    client = Telegram(..., library_path='/usr/lib/libtdjson.so.1.5.1')
