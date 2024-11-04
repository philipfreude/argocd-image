FROM quay.io/argoproj/argocd:v2.13.0

# Switch to root for the ability to perform install
USER root

# Install tools needed
RUN apt-get update && \
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        gnupg \
        curl && \
    curl -sS https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    apt-get update && \
    apt-get install -y \
        google-cloud-cli \
        google-cloud-sdk-gke-gcloud-auth-plugin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Switch back to non-root user
USER $ARGOCD_USER_ID
