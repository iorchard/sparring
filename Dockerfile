FROM    debian:buster-slim
ENV     TINI_VERSION v0.19.0
ENV     CIRROS_VERSION 0.5.1
ADD     https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD     http://download.cirros-cloud.net/${CIRROS_VERSION}/cirros-${CIRROS_VERSION}-x86_64-disk.img /tmp/cirros.img
ADD     . /sparring
RUN     apt update && \
        DEBIAN_FRONTEND=noninteractive apt install -y \
            python3 python3-dev python3-pip curl vim-tiny less && \
        python3 -m pip install wheel && \
        python3 -m pip install gabbi \
            robotframework robotframework-sshlibrary && \
        cd /sparring/robotframework-gabbilibrary && \
        python3 setup.py bdist_wheel && \
        python3 -m pip install dist/robotframework_gabbilibrary-*.whl && \
        chmod +x /tini && \
        echo $CIRROS_VERSION > /CIRROS_VERSION

ENTRYPOINT  ["/tini", "--", "/sparring/bin/sparring"]
CMD         ["--run-funcbot"]
