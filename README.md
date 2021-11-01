# Test uwsgi + apache locally

# Setup

Install vagrant (vagrant is a wrapper around virtualbox)

```
git clone <this repo>
cd <this repo>
vagrant up
vagrant ssh # go into machine/vm
```

# Connect
```
vagrant ssh
```
## Look around
```
systemctl status uwsgi.service # status of uwsgi
```

## uwsgi logs
```
sudo -i
journalctl -f -u uwsgi.service
```

## View test site (uwsgi vassal)
Note: on your host machine, we have to override the `Host` header
as a way of faking the hostname. 

Vagrant/Virtualbox is automatically configured to port forward port 
`8080` on the host to port `80` in the virtualbox machine.
```
curl -H "Host: testsite.subscriby.shop" -v http://127.0.0.1:8080
```

The above request

1. Port 8080 Gets fowarded to the virtualbox machine port 80
2. Apache (listening on port 80) forwards the request to uwsgi `ProxyPass`
   on port 8001
3. uwsgi inspects the host header, and locates the python wsgi application with the
   matching header.

If you want to view in a browser, use something like [Header Editor](https://chrome.google.com/webstore/detail/header-editor/eningockdidmgiojffjmkdblpjocbhgh/related?hl=en) or similar.

# Reset /destroy everything

```
./rebuild.sh
```
