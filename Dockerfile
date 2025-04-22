FROM garo/easy-xpra:latest
LABEL maintainer="Nikolas Garofil"
ARG APPUSERUID=1000
ARG APPGROUPGID=1000


RUN apk add --no-cache --update py3-cairo
RUN apk add --no-cache --update firefox-esr
RUN apk add --no-cache --update ttf-dejavu

COPY generatemachineid.py /root/generatemachineid.py
RUN /root/generatemachineid.py > /etc/machine-id && rm /root/generatemachineid.py

RUN addgroup --gid $APPGROUPGID appgroup && adduser --disabled-password --uid $APPUSERUID --ingroup appgroup appuser

USER appuser
WORKDIR /home/appuser
RUN mkdir -p .mozilla/firefox/abcdefgh.default
RUN echo 'user_pref("browser.tabs.remote.autostart", false);' > .mozilla/firefox/abcdefgh.default/user.js
RUN echo '[General]\n\
StartWithLastProfile=1\n\
\n\
[Profile0]\n\
Name=Default User\n\
IsRelative=1\n\
Path=abcdefgh.default\n\
' > .mozilla/firefox/profiles.ini

#Run firefox in xpra
CMD ["run_in_xpra", "firefox-esr"]
