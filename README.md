# pam_yubico Demo

<https://github.com/Yubico/yubico-pam>

```sh
vagrant up

# connect ssh access
vagrant ssh

# after launch VM, let's insert yubikey
mkdir ~/.yubico

# setting challenge response
ykpersonalize -2 -ochal-resp -ochal-hmac -ohmac-lt64 -oserial-api-visible

# store challenge of slot 2
ykpamcfg -2 -v

# edit pam.d files for exmaple
vi /etc/pam.d/gdm-password
auth     [success=done ignore=ignore default=bad] pam_selinux_permit.so
auth        substack      password-auth
auth        optional      pam_gnome_keyring.so
auth        include       postlogin
# add pam_yubico configration
auth        required      pam_yubico.so       mode=challenge-response debug

account     required      pam_nologin.so
account     include       password-auth

password    substack       password-auth
-password   optional       pam_gnome_keyring.so use_authtok

session     required      pam_selinux.so close
session     required      pam_loginuid.so
session     optional      pam_console.so
session     required      pam_selinux.so open
session     optional      pam_keyinit.so force revoke
session     required      pam_namespace.so
session     include       password-auth
session     optional      pam_gnome_keyring.so auto_start
session     include       postlogin
```

## Trouble shoot

* Check YubiKey has inserted

```sh
# reinsert yubikey and check
sudo tailf /var/log/message
```

* `.yubico` folder parmission

```sh
# .yubico folder permission must set mode 700
chmod 700 ~/.yubico/
```
