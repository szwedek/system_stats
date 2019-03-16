#!/usr/bin/env python

import sys
import json

import psycopg2
try:
    conn = psycopg2.connect("dbname='db' user='reader' host='db' password='reader'")
except:
    print 'I am unable to connect to the database'
    sys.exit(1)


from flask import Flask
app = Flask(__name__)

@app.route('/stats')
def stats():
    cur = conn.cursor()
    cur.execute('SELECT type, count(*) FROM events GROUP BY type')
    rows = cur.fetchall()
    cur.close()
    return json.dumps(dict(map(lambda x: (x[0], int(x[1])), rows)))

if __name__ == '__main__':
    app.run()
