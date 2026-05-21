# pearl-miner

One-command installer for [Pearlhash](https://pearlhash.xyz) Pearl (PRL) mining pool.

> Pearl is the proof-of-useful-work coin of the AI compute era. Pool routes your GPUs and pays back in PRL after every epoch.

## Quick start

```bash
curl -fsSL https://raw.githubusercontent.com/bibnk/pearl-miner/main/mine.sh | bash
```

Or clone:

```bash
git clone https://github.com/bibnk/pearl-miner.git
cd pearl-miner
bash mine.sh
```

## What it does

1. Download `pearl-miner` binary from `pearlhash.xyz/downloads/pearl-miner-v4` (skip if already present)
2. `chmod +x` the binary
3. Run it pointed at the pool with the configured wallet

## Configuration

Edit the top of `mine.sh`:

```bash
WALLET="prl1...your-wallet-here"
HOST="84.32.220.219:9000"
BINARY_URL="https://pearlhash.xyz/downloads/pearl-miner-v4"
```

## Persistent run (background)

With `screen`:

```bash
screen -S pearl -dm bash mine.sh
screen -r pearl    # attach
# Ctrl+A then D to detach
```

With `tmux`:

```bash
tmux new -d -s pearl 'bash mine.sh'
tmux attach -t pearl
```

With `systemd` (auto-restart on crash, auto-start on boot):

```ini
# /etc/systemd/system/pearl-miner.service
[Unit]
Description=Pearl Miner
After=network-online.target

[Service]
Type=simple
User=root
WorkingDirectory=/root/pearl-miner
ExecStart=/usr/bin/bash /root/pearl-miner/mine.sh
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl enable --now pearl-miner
sudo journalctl -u pearl-miner -f
```

## Verify earnings

Look up your wallet at:

```
https://pearlhash.xyz/?lookup=YOUR_WALLET
```

Minimum payout is 50 PRL. Rewards distribute every epoch.

## License

MIT — see [LICENSE](./LICENSE)
