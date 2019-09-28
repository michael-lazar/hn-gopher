#!/usr/bin/env python3
"""
This is a custom CGI-style script that manages the guestbook operations.
"""

import os
import sys
import sqlite3
import textwrap
from functools import partial
from datetime import datetime

from unidecode import unidecode

DB_FILE = '/var/lib/hngopher/hngopher.db'
GUESTBOOK_GOPHERMAP = '/var/gopher/guestbook/gophermap'


def connect_db():
    """
    Use an SQLite database to store the guestbook data.
    """
    db = sqlite3.connect(DB_FILE, detect_types=sqlite3.PARSE_DECLTYPES)
    cursor = db.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS guestbook (
          id int PRIMARY KEY,
          session int,
          message text,
          created timestamp,
          ip_address text,
          ip_location text);
        """)
    db.commit()
    return db, cursor


def dump_gophermap(cursor):
    """
    Load entries from the SQLite3 database and write them to a gophermap.

    It's faster to preload the gophermap vs generating it on demand via
    CGI. Performance is especially noticeable on a Raspberry Pi 1 B, where
    it can take seconds to launch the Python 3 runtime using CGI.
    """
    cursor.execute("""
        SELECT
            created,
            message
        FROM guestbook
        ORDER BY created DESC
        """)

    with open(GUESTBOOK_GOPHERMAP, 'w') as fp:
        fp.write(textwrap.dedent(r"""
            i[HN Gopher] Guestbook
            i 
            i (`/\
            i `=\/\ __...--~~~~~-._   _.-~~~~~--...__
            i  `=\/\               \ /    HN GOPHER  \\
            i   `=\/                V    GUEST BOOK   \\
            i   //_\___--~~~~~~-._  |  _.-~~~~~~--...__\\
            i  //  ) (..----~~~~._\ | /_.~~~~----.....__\\
            i ===(     )==========\\|//====================
            i_____\___/___________`---`___________________________________________
            i 
            1Sign the guestbook!	/guestbook/new
            i 
            """.lstrip('\n')))

        p = partial(print, file=fp)
        for row in cursor.fetchall():
            p('i{}'.format(row[0].strftime('%Y-%m-%d %I:%M %p')))
            for line in row[1].split('\n'):
                p('i' + line)
            p('i ')
        p('i' + 26 * ' ' + '~ Thank you ~')


def add_entry(db, cursor):
    """
    Save the query text in the guestbook database.

    Gophernicus will take the text printed to stdout and add it to
    the gophermap response.
    """
    if len(sys.argv) == 2 and sys.argv[1] == 'dump':
        # Shortcut to rebuild the gophermap without submitting a new post
        return

    message = unidecode(os.environ['QUERY_STRING'])
    message = '\n'.join(textwrap.wrap(message, 65)[:10])
    if not message:
        print('iError, no text submitted!')
        print('i ')
        return

    timestamp = datetime.utcnow()
    ip_address = os.environ['REMOTE_ADDR']
    session_id = os.environ['SESSION_ID']

    # I previously used geolocation to display where the messages were being
    # posted from. But I noticed that the locations were often inaccurate and
    # international addresses were incomplete or mangled.
    ip_location = None

    cursor.execute("""
        INSERT INTO guestbook(
          session,
          message,
          created,
          ip_address,
          ip_location)
        VALUES (?, ?, ?, ?, ?);
        """, (session_id, message, timestamp, ip_address, ip_location))
    db.commit()

    print('iYour message has been posted!')
    print('i ')
    print('iIn order to see your submission, you might need to reload')
    print('iyour gopher client in order to refresh the page cache.')


def main():
    try:
        db, cursor = connect_db()
        add_entry(db, cursor)
        dump_gophermap(cursor)
        # Print all of the CGI environment variables to the page
        # for key, val in sorted(os.environ.items()):
        #     print('i{:20}: {}'.format(key, val))
    except Exception as e:
        # Catch all exceptions to prevent dumping potentially sensitive
        # text to stdout/stderr
        print('i' + str(e))
        print('i ')
        print('iERROR: The server has encountered a fatal error!')


if __name__ == '__main__':
    main()
