#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# @author : microfat
# @time   : 07/29/20 09:55:56
# @File   : ip_request.py

import logging
import requests
from flask import Blueprint, abort, jsonify

def get_logger():
    """
    创建日志实例
    """
    formatter = logging.Formatter("[%(asctime)s] - %(message)s")
    logger = logging.getLogger("monitor")
    logger.setLevel(logging.INFO)

    ch = logging.StreamHandler()
    ch.setFormatter(formatter)
    logger.addHandler(ch)
    return logger

logger = get_logger()

ip_request_blueprint = Blueprint('ip_request_blueprint', __name__)

@ip_request_blueprint.errorhandler(429)
def too_many_requests(e):
    return jsonify(error=str(e)), 429

@ip_request_blueprint.errorhandler(404)
def not_found(e):
    return jsonify(error=str(e)), 404

@ip_request_blueprint.route('/', methods=['GET'])
def get_ip():
    url_get_ip = 'http://webapi.http.zhimacangku.com/getip?num=1&type=2&pro=&city=0&yys=0&port=1&time=1&ts=1&ys=1&cs=1&lb=1&sb=0&pb=45&mr=1&regions='
    try:
        r = requests.get(url=url_get_ip)
    except:
        logger.error("失败！")
        abort(404, description='Not Found')

    if r.json()['code'] == 111:
        logger.error(r.json()['msg'])
        abort(429, description="Too Many Requests")
    else:
        logger.info("成功！")
        return r.json()