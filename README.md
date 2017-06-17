# hn-gopher

## How to view this site

Unfortunately, the gopher protocol hasn't been supported by major web browsers since the early 2000's. However, there are still a few good options for accessing Gopher in the modern age.

- Use **lynx** from the command line
   ```bash
   $ lynx gopher://hngopher.com
   ```
<img src="resources/lynx_screen.png" height="700">

- Install the free [OverbiteFF](https://addons.mozilla.org/en-US/firefox/addon/overbiteff/)
   addon for Firefox

<img src="resources/overbite_screen.png" height="700">
   
- If you're lazy, Floodgap has setup a gateway that converts *gopher* to *http* so it
   can be viewed from any browser.
   - http://gopher.floodgap.com/gopher/gw?a=gopher%3A%2F%2Fhngopher.com

<img src="resources/floodgap_screen.png" height="700">


## How to deploy this project

This server runs on Debian 8.7, but it should work on any Linux system that's capable of building [gophernicus](https://github.com/prologic/gophernicus). There's a ``deploy.sh`` script included in the repo that can be used
to automatically setup a server listening on port 70 and a cron job that polls the Hacker News API.

```bash
$ git clone https://github.com/michael-lazar/hn-gopher.git
$ cd hn-gopher
$ sudo ./deploy
```
