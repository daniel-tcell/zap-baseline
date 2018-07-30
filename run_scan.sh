#!/bin/bash
readonly ip="$1"
readonly port="$2"
docker run -it --rm -v $(pwd)/zap:/zap/wrk \
    -t tcell-zap zap-baseline-custom.py \
    -t http://$ip:$port/WebGoat/start.mvc \
    --auth_loginurl http://$ip:$port/WebGoat/login.mvc \
    --auth_username guest --auth_password guest --auth_auto \
    --auth_exclude http://$ip:$port/WebGoat/j_spring_security_logout,http://$ip:$port/WebGoat/j_spring_security_check.* \
    -c genfig.conf \
    -m 3 \
    -r report.html \
    -n test2.context \
    -d \
    -j -z "-config connection.timeoutInSecs=300"
