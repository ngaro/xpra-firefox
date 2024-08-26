# xpra-firefox

This runs Firefox in Xpra so you can attach to it from different systems.

Xpra allows you to use the speed of X-forwarding (a bit faster even) and the detach/attach possibilities of VNC.

## Tags

* [latest](https://github.com/ngaro/xpra-firefox/blob/latest/Dockerfile) uses Alpine as base
* [ubuntu](https://github.com/ngaro/xpra-firefox/blob/ubuntu/Dockerfile) uses Ubuntu as base
* [ubudev](https://github.com/ngaro/xpra-firefox/blob/ubudev/Dockerfile) uses Firefox Developer Edition on Ubuntu

## XPRA Usage

To run Firefox on 'fireserver' listening for xpra-connections on tcp/12345 for clients that want to use it:

* Run the container:

`docker run -d -p 12345:10000 --name xprafire -v /dev/shm:/dev/shm --device /dev/snd garo/xpra-firefox`

* Wait a couple of seconds for everything to start...

* You can now use xpra on a client to connect to it with: `xpra attach tcp:fireserver:12345`

* If you detach the xpra connection from the client firefox will continue to run.

* Closing Firefox will also stop the container. With `docker start xprafire` it will start again.

The environment variable `XPRA_PORT` is `10000` by default but can be changed to make xpra listen to another port.

## Regular (local) usage

You can also use this to run firefox locally in a container:

```
docker run -d --net host -e DISPLAY=$DISPLAY --rm -v /dev/shm:/dev/shm \
--device /dev/snd -v $HOME/.Xauthority:/root/.Xauthority garo/xpra-firefox
```

## Issues

* Sound doesn't work in the ubuntu version

## Development
Want to improve this (bugfixes, extra features, ...) ?

Fork this repository on GitHub instead of cloning it,
I and other users might be interested in your changes !
