#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# @author : microfat
# @time   : 07/29/20 10:49:11
# @File   : app.py

from flask import Flask
from ip_request import ip_request

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False
app.register_blueprint(ip_request.ip_request_blueprint, url_prefix='/newip')

if __name__ == '__main__':
    app.run(port=8000)