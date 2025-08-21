ARG VERSION=latest

FROM bitnami/kubectl:${VERSION}

USER root

RUN apt update; \
  apt install -y curl; \
  curl -LO https://github.com/hashmap-kz/kubectl-envsubst/releases/latest/download/kubectl-envsubst_linux_amd64.deb; \
  dpkg -i kubectl-envsubst_linux_amd64.deb; \
  rm kubectl-envsubst_linux_amd64.deb; \
  apt remove -y curl; \
  apt autoremove -y; \
  rm -rf /var/lib/apt/lists/*

USER 1001