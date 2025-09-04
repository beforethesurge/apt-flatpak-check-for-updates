# Apt/Flatpak Check for Updates

Recommend creating a crontab for this script, that way you can ignore this until a certain time

- Note that this will need to be ran by either root (`sudo crontab -e`) or a passwordless sudo (not recommended unless you know what you're doing)

For example (change with wherever you want the script):

```sh
HOME=/home/changeme
0 22 * * * $HOME/path/to/script >> $HOME/path/to/log/update.log 2>&1
```

- This runs every day at 22:00 (10 pm)
