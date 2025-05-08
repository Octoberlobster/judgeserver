# Use ubuntu:20.04 as the base image
FROM ubuntu:20.04

# Define arguments for user configuration
ARG USERNAME=judge_server
ARG USER_UID=1001
ARG USER_GID=$USER_UID

# Create user and group, install sudo, and configure sudoers
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Install required packages and DMOJ
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y python3-dev python3-pip build-essential libseccomp-dev \
    && pip3 install dmoj \
    && dmoj-autoconf

COPY entrypoint.sh /home/judge_server/entrypoint.sh

RUN chown $USERNAME:$USERNAME /home/judge_server/entrypoint.sh && \
    chmod +x /home/judge_server/entrypoint.sh

# Switch to the created user
USER $USERNAME

# Define environment variables with default values
ENV server_ip="localhost" \
    TOKEN="default_token" \
    judge_server_id="judge1"

# Create volume for problems
VOLUME /home/judge_server/problems



# Set entrypoint
ENTRYPOINT ["/home/judge_server/entrypoint.sh"]