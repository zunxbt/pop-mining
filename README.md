<h2 align=center>PoP Mining Guide by ZunXBT</h2>

## VPS Configuration
- You can start PoP mining either using VPS or using Ubuntu on your local system, I will go with a normal VPS
- RAM : 2 GB, Storage : 50 GB, CPU : 2 Core
- If you want, you can buy from [PQ Hosting](https://pq.hosting/?from=622403&lang=en) using crypto currency

## Installation
```bash
[ -f "hemixyz.sh" ] && rm hemixyz.sh; wget -q https://raw.githubusercontent.com/zunxbt/pop-mining/main/hemixyz.sh && chmod +x hemixyz.sh && ./hemixyz.sh
```

- **Copy all these details and save it somewhere**
```bash
cat ~/popm-address.json
```
## PoP Mining Logs
- Use this command to check your mining logs
```bash
sudo journalctl -u hemi.service -f -n 50
```

## Overall stats
- Visit [this website](https://testnet.popstats.hemi.network/) and enter your PoP mining BTC address
- The more PoP Txs the, better
