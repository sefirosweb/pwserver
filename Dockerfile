# Base image
FROM ubuntu:22.04

WORKDIR /data
# Install dependencies
RUN dpkg --add-architecture i386
RUN apt update
RUN apt install -y curl wget file tar bzip2 gzip unzip 
RUN apt install -y bsdmainutils python3 util-linux ca-certificates 
RUN apt install -y binutils bc jq tmux netcat lib32gcc-s1 lib32stdc++6 libsdl2-2.0-0:i386
RUN apt install -y cpio distro-info xz-utils

# Install steamcmd
RUN echo steam steam/question select "I AGREE" | debconf-set-selections
RUN echo steam steam/license note '' | debconf-set-selections
RUN apt install -y steamcmd --force-yes

RUN adduser pwserver
USER pwserver

WORKDIR /home/pwserver
RUN curl -Lo linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh pwserver
RUN /home/pwserver/pwserver auto-install
RUN mv /home/pwserver/serverfiles /home/pwserver/serverfiles-backup

# Copy the server file entrypoint
COPY --chown=pwserver:pwserver entrypoint.sh /home/pwserver/entrypoint.sh
RUN chmod +x /home/pwserver/entrypoint.sh


EXPOSE 8211
EXPOSE 27015

# Below are the recommended cron tasks.
# */5 * * * * /home/pwserver/pwserver monitor > /dev/null 2>&1
# */30 * * * * /home/pwserver/pwserver update > /dev/null 2>&1
# 0 0 * * 0 /home/pwserver/pwserver update-lgsm > /dev/null 2>&1

CMD ["/home/pwserver/entrypoint.sh"]