- Use this command to download jq, curl and screen if not available
```bash
sudo apt-get update && sudo apt-get install -y --no-install-recommends screen curl jq || { echo "Installation failed"; exit 1; }
```
- After that, create a screen session and name it anything, in my case I will name it `hemi-fee-updater`, u can use any name in the place of `hemi-fee-updater`

```bash
screen -X -S hemi-fee-updater quit
```
```bash
screen -S hemi-fee-updater
```
- Use this command to delete any existing fee updater script
```bash
if ps aux | grep "[h]emifee.sh" > /dev/null; then
    ps aux | grep "[h]emifee.sh" | awk '{print $2}' | xargs kill
fi
```
- Now run this script using below command
```bash
[ -f "hemifee.sh" ] && rm hemifee.sh; curl -sSL -o hemifee.sh https://raw.githubusercontent.com/zunxbt/pop-mining/refs/heads/main/hemifee.sh && chmod +x hemifee.sh && ./hemifee.sh
```
- **Now press `Ctrl` + `A` + `D` (VERY IMP) after that u can close your VPS**
- DONE, it will automatically fetch the fee and will update in the service file in every 10 mins
