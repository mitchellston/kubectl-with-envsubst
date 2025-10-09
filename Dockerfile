ARG VERSION=latest
ARG TARGETPLATFORM

FROM bitnami/kubectl:${VERSION}

ARG TARGETPLATFORM
USER root

RUN tdnf install curl gettext; \
  # Install kubectl-envsubst
  OS="$(uname | tr '[:upper:]' '[:lower:]')"; \
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"; \
  TAG="$(curl -s https://api.github.com/repos/hashmap-kz/kubectl-envsubst/releases/latest | jq -r .tag_name)"; \
  curl -L "https://github.com/hashmap-kz/kubectl-envsubst/releases/download/${TAG}/kubectl-envsubst_${TAG}_${OS}_${ARCH}.tar.gz" | tar -xzf - -C /usr/local/bin && chmod +x /usr/local/bin/kubectl-envsubst; \
  # Cleanup
  tdnf erase curl -y; \
  tdnf clean all

USER 1001
