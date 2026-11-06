# Cleaning an LG 65UM7660PVA (webOS 4.10.2-29, Egypt)

Target TV (from its About This TV screen): model 65UM7660PVA, webOS TV version 4.10.2-29 (goldilocks2-grampians), software version 05.40.97, region Egypt.

## What is and isn't possible on this TV

| Goal | Status |
|---|---|
| Disable or uninstall LG's ad and telemetry packages (what [CleanYourTV](https://github.com/Gathin23/cleanyourtv) does) | **Not possible.** It needs Android's ADB; webOS has no equivalent on retail firmware. |
| Replace the home screen with an Apple TV style launcher | **Not verified on this TV.** The community [webOS port](https://github.com/Razdva122/clean-your-tv-lg-webos) lists no 2019 or webOS 4.x set as tested, and says untested models and firmware must not be assumed to work. It also leaves LG's ads and telemetry in place. |
| Apple TV 4K look and feel | **Use an Apple TV 4K box** on an HDMI input. It replaces LG's home screen completely. |
| Stop the TV's tracking and ads | Do both steps below: the TV's own settings, then DNS blocking. |

## Step 1: Use the TV only as a screen

1. Connect an Apple TV 4K (or other streaming box) to an HDMI port.
2. Use that input for everything. Don't open LG's home screen or LG apps.
3. If the box has its own internet, consider taking the TV off Wi-Fi (or Ethernet) entirely once Step 2 is done. A TV with no network can't send data. You lose LG firmware updates, so do any update first.

## Step 2: Turn off what the TV offers

Menu paths differ by webOS version, and LG's published pages I found cover webOS 6 and 22, not 4.x. Treat the list below as things to look for under **Settings > General** (the screen you opened for About This TV) and **Safety**, then switch off on your set:

- Home promotion / home screen advertising
- Content recommendations
- Advertising: limit ad tracking, and reset the advertising ID
- Live Plus and viewing-information services (LG's older guide says enabling Live Plus consents to viewing-data collection)
- Home auto-launch

LG references (other webOS versions, so check the wording on your set): [Home Promotion off, webOS 6.0/22](https://www.lg.com/uk/support/product-support/troubleshoot/help-library/cs-CT00008333-20153529296869/), [ads while watching TV (India)](https://www.lg.com/in/support/product-support/troubleshoot/help-library/cs-CT52006584-20153905578425OLT/), [ads while watching TV (US)](https://www.lg.com/us/support/help-library/lg-tv-advertising-messages-or-images-appear-when-im-watching-tv--20154860356295). LG's Egypt support site is at lg.com/eg_en.

## Step 3: Block the TV's tracking at your router

I haven't put a blocklist in this repo because I couldn't verify one against an official source. Build one from your own network instead:

1. Run Pi-hole or another dnsmasq-based DNS server, and make the router hand it out as DNS (or use [NextDNS](https://nextdns.io) and read its logs).
2. Give the TV a fixed IP in the router.
3. Use the TV normally for a day, then run: `tools/tv-dns-report.sh <tv-ip>` on the Pi-hole host. It lists every domain the TV looked up, most frequent first.
4. Block the domains that are clearly advertising, analytics or telemetry. Leave anything the TV needs to work, such as time sync and the apps you actually use.
5. After each change check that your apps still play, and undo any block that breaks one.

If the TV has hard-coded DNS servers (it keeps working with your DNS blocked), add a router rule that redirects or drops outbound port 53 from the TV's IP.
