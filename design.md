# Problem Statement

How can I receive rapid notification of motion inside my house?

# Basic premise

WESS, the Webcam Security System, can be installed to a machine or run from a live USB. WESS integrates with `motion`, a Linux CLI program that can save images and run actions when motion is encountered. WESS can be configured to start up with a locked screen, or it can be started manually by simply running `wess`. WESS can be disabled from $HOST port 9290, via a simple web interface. WESS offers the ability to send emails containing still frames of motion.

# MoSCoW

## Must have:

Start up via `wess`

Shutdown via `killall wess`

Enable via `wess enable`

Disable via `wess disable`

Save images to gmail

## Should have

Encrypt and load password for gmail, dropbox

Save images, video to dropbox

Secure web interface to enable/disable wess over wifi or over the internet

Persistent Ubuntu USB key, wess starts disabled by default

## Could have:

Streaming video of webcam capture

## Want to have:

Full encryption of the persistent usb iso

VPN to arbitrary FTP

REST API

# Proposed directory structure

```
ZMQ, Postgres, Mojolicious
wess
|- wess.pl
|- lib
|  |- WESS.pm
|  +- WESS
|     +- Controller
|        +- Admin.pm
|           +- Users.pm
|           +- Logs.pm
|           +- Config.pm
|        +- ToggleSwitch.pm
|        +- Livefeed.pm
|     +- Model
|        +- Admin.pm
|           +- Users.pm
|           +- Logs.pm
|           +- Config.pm
|               +- Text.pm
|        +- System
|           +- Daemon.pm
|               +- Status.pm
|           +- DaemonCommand.pm
|        +- ToggleSwitch
|        +- Livefeed
|           +- mjpeg
|     +- Storage
|           +- Helpers
|               +- Mojo::pg
|     +- Subscriptions
|           +- Helpers
|               +- ZMQ::FFI
|- t
|  +- login.t
|  +- users.t
|  +- config.t
|  +- logs.t
|  +- daemon.t
|  +- daemoncommand.t
|  +- toggleswitch.t
|  +- mojo_pg_helps_storage.t
|  +- zmq_ffi_helps_subscriptions.t
|  +- bin
|   +- wess.t
+- templates
|   |- layouts
|   |  +- default.html.ep
|   |- index.html.ep
|   +- protected.html.ep
|   |- admin.html.ep
|   |- toggle_motion.html.ep
|   |- livefeed.html.ep
|- bin
|   +- wess-start
|   +- wess-stop
|   +- wess-status
|   +- wess-enable
|   +- wess-disable
|   +- wess-send
|   +- wess-listen
```
