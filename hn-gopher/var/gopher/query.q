#!/usr/bin/env python3
import os

print('Hello ' + os.environ.get('QUERY_STRING') + '!')
