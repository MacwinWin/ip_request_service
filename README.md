# request_ip_service
Web service to request zhima high anonymous ip address
Returns json data about a zhima ip.

## Project Structure

[![Documentation](https://img.shields.io/badge/Flask-1.1.0%2B-lightgrey.svg)](https://flask.palletsprojects.com/)

[![Documentation](https://img.shields.io/badge/uWSGI-2.0%2B-green.svg)](https://uwsgi-docs.readthedocs.io/en/latest/)

[![Documentation](https://img.shields.io/badge/NGINX-1.19.1%2B-brightgreen.svg)](https://nginx.org/en/docs/)

[![Documentation](https://img.shields.io/badge/Docker-19.03.12%2B-Blue.svg)](https://docs.docker.com/)


## File Structure
```
.
├── app.py
├── docker-compose.yml
├── Dockerfile
├── ip_request
│   └── ip_request.py
├── nginx.conf
├── README.md
├── requirements.txt
├── sources.list
├── supervisord.conf
└── uWSGI.ini
```

1 directories, 10 files

## Installation
**Start with Docker**
```bash
git clone https://github.com/MacwinWin/ip_request_service.git
cd ip_request_service
# you can run this command everytime you need to start superset now:
docker-compose up
```

## API doc

**URL** : `127.0.0.1:8000/newip`

**Method** : `GET`

### Success Response

**Code** : `200 OK`

**Content examples**

```json
{
    "code": 0,
    "data": [
        {
            "city":"四川省乐山市",
            "expire_time":"2020-07-29 17:42:57",
            "ip":"119.5.178.204",
            "isp":"联通",
            "port":4258
        }
    ],
    "msg": "0",
    "success": true
}
```

### 429 TOO MANY REQUESTS

**Code** : `429 TOO MANY REQUESTS`

**Content examples**

```json
{
    "error": "429 Too Many Requests: Too Many Requests"
}
```

### 404 Not Found

**Code** : `404 Not Found`

**Content examples**

```json
{
    "error": "404 Not Found: Not Found"
}
```

## Notes

* If request too many, response may be 429, you just wait 2 seconds and try again.