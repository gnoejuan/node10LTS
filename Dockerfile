# Copyright (c) 2012-2018 Red Hat, Inc.
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# Contributors:
#   Red Hat, Inc. - initial API and implementation

FROM eclipse/stack-base:debian

RUN  echo "Acquire::http::Proxy \"http://192.168.1.5:3142\";" | sudo tee /etc/apt/apt.conf.d/00proxy
RUN sudo apt-get update && \
    sudo apt-get -y install build-essential libkrb5-dev gcc make debian-keyring python2.7 && \
    sudo apt-get clean && \
    sudo apt-get -y autoremove && \
    sudo apt-get -y clean && \
    sudo rm -rf /var/lib/apt/lists/*

RUN wget -qO- https://deb.nodesource.com/setup_10.x | sudo -E bash -
RUN sudo apt update && sudo apt -y install nodejs

EXPOSE 1337 3000 4200 5000 9000 8003
RUN sudo npm i -g npm
RUN sudo npm install --unsafe-perm -g yarn gulp bower grunt grunt-cli yeoman-generator yo generator-angular generator-karma generator-webapp typescript typescript-language-server puppeteer
LABEL che:server:8003:ref=angular che:server:8003:protocol=http che:server:3000:ref=node-3000 che:server:3000:protocol=http che:server:9000:ref=node-9000 che:server:9000:protocol=http