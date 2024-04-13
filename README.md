# Faction Free Unit Popup
Name:   addon-Faction-Free-Unit-Popup \
Author:   gitdalisar \
Repository:   https://github.com/gitdalisar/addon-faction-free-unit-popup \
Download:   https://github.com/gitdalisar/addon-faction-free-unit-popup/archive/refs/heads/main.zip \
License:   GNU Affero General Public License v3.0

Designed and Implemented for AzerothCore (https://azerothcore.org). If you are running a different server version, please review the files before loading into your environment!

## Purpose
When using the AllowTwoSides settings in worldserver.conf there are still features that do not show in the unit popup menu that appears when right-clicking a targeted player. This is due to the UnitPopup.xml file used by the WOW client. Leveraging that file resulted in multiple errors as some functions cannot be executed by an addon to prevent certain actions. Additionally, some functions cannot be performed on an opposing faction with addons or serverside code as the client has a hard check internally for faction. While that does prohibt several functions, this addon adds two basic functions to that menu as essentially a Quality of Life improvement for players.

## How it works
For installation, as this is an addon, you simply need to copy the folder "FactionFreeUnitPopup" into your client's /Interface/AddOns directory.

Items that could *_NOT_* be made to work in the Unit Popup Menu and why:
- Set Focus cannot be allowed as that is a form of "targeting" and being able to script the act of targeting and thus possibly script combat and as such is not allowed by the client.
- Follow cannot be allowed as that would allow you to follow an opposing faction player in something like a battleground thus leading to unfair gameplay and thus is not allowed by the client. 
- Trade cannot be allowed as that would have broken the auction house set up in this day where there is an "alliance" and a "horde" and a "neutral" auction house and thus is not allowed by the client.

What this addon *_DOES_* make available:
- If you are NOT in the party with the opposing faction target:
  - Hide Set Focus to prevent addon error
  - Add ability to whisper off a right-click
  - Add ability to invite off a right-click
- If you ARE in the party with the opposing faction target, give full menu support

## Contact Info
If you would like to ask any questions, you can find me on the AzerothCore Discord as @Dalisar so feel free to DM me there!

## Special Thanks!
Special thanks to the AC and WOW Modding communities for their support. Also, special shout out to those assisting in testing and code review:
@GitFinntastic, @GitVenyce

## Change Log
v1.0.0: March 12, 2024
- Initial Release
