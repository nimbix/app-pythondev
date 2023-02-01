FROM ubuntu:focal

# Install jarvice-desktop tools and desktop from Nimbix repository
ENV JARVICE_DESKTOP_ITER 1
RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install ca-certificates curl --no-install-recommends && \
    curl -H 'Cache-Control: no-cache' \
        https://raw.githubusercontent.com/nimbix/jarvice-desktop/master/install-nimbix.sh \
    | bash -s

RUN apt-get -y install python3-pip python3-dev && apt-get -y clean all

# get latest link CE here: https://www.jetbrains.com/pycharm/download/other.html
ENV PYCHARM_URL https://download.jetbrains.com/python/pycharm-community-2022.3.2.tar.gz?_ga=2.216242590.925137685.1675265226-1903941416.1674485690&_gl=1*17msw69*_ga*MTkwMzk0MTQxNi4xNjc0NDg1Njkw*_ga_9J976DJZ68*MTY3NTI2NTIyNS4yLjEuMTY3NTI2NjAxNC41OS4wLjA.
WORKDIR /opt
RUN curl -L ${PYCHARM_URL} |tar xzf -

COPY launch.sh /usr/local/bin/launch.sh

COPY AppDef.json /etc/NAE/AppDef.json

RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://cloud.nimbix.net/api/jarvice/validate

RUN mkdir -p /etc/NAE && touch /etc/NAE/screenshot.png /etc/NAE/screenshot.txt /etc/NAE/license.txt /etc/NAE/AppDef.json
