script_path=$(dirname $(realpath -s $0))

sudo snap install --classic certbot
sudo snap set certbot trust-plugin-with-root=ok
sudo snap install --classic certbot-dns-cloudflare
sudo ln -s /snap/bin/certbot /usr/bin/certbot

sudo certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials $script_path/../secrets/certbot-cloudflare.ini \
  -d unscripted.dev -d *.unscripted.dev
