# Spellup-Plugin
This plugin handles spells and skill that fall in to the spellup catagory. It recasts any spells, and some skills, that expire.

To install this plugin you need to download the zip file and then place everything in the src directory in to the Blowtorch 
plugins directory. You may need to make a Shindo_lua subdirectory in the plugins directory, for the the lua file.

## BlowTorch Installation instructions  
Before installing you will need to make the following changes to Blowtorch settings.
1. Bring up the menu with the menu key in the top right corner.
2. Select **Options**, then **Service**, then **GMCP Options**
3. Pleae make sure **Use GMCP** is ticked on the right hand side.
4. Press **Support String** and put "char 1" **WITH THE ""**. If there are any other options already there then you 
need a *comma* between the options. For example: "char 1", "room 1", "comm 1"

## Aardwolf Installation instructions
You need to send the following command to the mud to turn spellup tags on: **tags spellups on**  
Failure to do so will result in the plugin not working as it requires the tags to work.
