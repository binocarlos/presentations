```json
{
    "family": "webservers",
    "containerDefinitions": [{
        "name": "webserver-ubuntu",
        "image": "binocarlos/webserver-ubuntu",
        "portMappings": [{
            "containerPort": 80,
            "hostPort": 8081,
            "protocol": "tcp"
        }],
        "environment": [
            {
                "name": "SERVER_COUNT",
                "value": "1"
            }
        ]
    },{
        "name": "webserver-ubuntu",
        "image": "binocarlos/webserver-ubuntu",
        "portMappings": [{
            "containerPort": 80,
            "hostPort": 8082,
            "protocol": "tcp"
        }],
        "environment": [
            {
                "name": "SERVER_COUNT",
                "value": "2"
            }
        ]
    },{
        "name": "webserver-ubuntu",
        "image": "binocarlos/webserver-ubuntu",
        "portMappings": [{
            "containerPort": 80,
            "hostPort": 8083,
            "protocol": "tcp"
        }],
        "environment": [
            {
                "name": "SERVER_COUNT",
                "value": "3"
            }
        ]
    },{
        "name": "webserver-centos",
        "image": "binocarlos/webserver-centos",
        "portMappings": [{
            "containerPort": 80,
            "hostPort": 8084,
            "protocol": "tcp"
        }],
        "environment": [
            {
                "name": "SERVER_COUNT",
                "value": "4"
            }
        ]
    },{
        "name": "webserver-centos",
        "image": "binocarlos/webserver-centos",
        "portMappings": [{
            "containerPort": 80,
            "hostPort": 8085,
            "protocol": "tcp"
        }],
        "environment": [
            {
                "name": "SERVER_COUNT",
                "value": "5"
            }
        ]
    },{
        "name": "webserver-centos",
        "image": "binocarlos/webserver-centos",
        "portMappings": [{
            "containerPort": 80,
            "hostPort": 8086,
            "protocol": "tcp"
        }],
        "environment": [
            {
                "name": "SERVER_COUNT",
                "value": "6"
            }
        ]
    }]
}
```