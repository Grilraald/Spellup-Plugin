# Spellup-Plugin
This plugin handles spells and skill that fall in to the spellup catagory. It recasts any spells, and some skills, that expire.

To install this plugin you need to either download the zip file and then place everything from the src directory in to the Blowtorch 
plugins directory or you need to download the xml and lua file via raw mode. You may need to make a Shindo_lua subdirectory in the plugins directory, for the the lua file.

## BlowTorch Installation instructions  
Before installing you will need to make the following changes to Blowtorch settings.
1. Bring up the menu with the menu key in the top right corner.
2. Select **Options**, then **Service**, then **GMCP Options**
3. Pleae make sure **Use GMCP** is ticked on the right hand side.
4. Press **Support String** and put "char 1" **WITH THE ""**. If there are any other options already there then you 
need a *comma* between the options. For example: "char 1", "room 1", "comm 1"
5. Restart your aardwolf session. you do not need to quit, you can use the menu quit option then sign in again.

## Aardwolf Installation instructions
You need to send the following command to the mud to turn spellup tags on: **tags spellups on**  
Failure to do so will result in the plugin not working as it requires the tags to work.

## Debugging Options
To help with issues of the status not changing i've added a function to turn debugging on and off.  Debugging is off by default. In order to turn it on type **.SpellupDebug 1**, this will report each time the char.status is sent to the client and might be very spammy. To turn debugging off type **.SpellupDebug 0**.  
Please note that you need to put a period in front of commands that you send to the plugin.
