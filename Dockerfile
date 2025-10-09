ARG VERSION=latest
ARG TARGETPLATFORM

FROM bitnami/kubectl:latest

ARG TARGETPLATFORM
USER root

RUN apt update; \
  apt install -y curl gettext-base; \
  if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
    curl -LO https://github.com/hashmap-kz/kubectl-envsubst/releases/latest/download/kubectl-envsubst_linux_amd64.deb; \
    dpkg -i kubectl-envsubst_linux_amd64.deb; \
    rm kubectl-envsubst_linux_amd64.deb; \
  elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
    curl -LO https://github.com/hashmap-kz/kubectl-envsubst/releases/latest/download/kubectl-envsubst_linux_arm64.deb; \
    dpkg -i kubectl-envsubst_linux_arm64.deb; \
    rm kubectl-envsubst_linux_arm64.deb; \
  fi; \
  apt remove -y curl; \
  apt autoremove -y; \
  rm -rf /var/lib/apt/lists/*

USER 1001
