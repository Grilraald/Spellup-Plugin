-- Colour Stuff
local ansi = "\27["
local dred = "\27[0;31m"
local dgreen = "\27[0;32m"
local dyellow = "\27[0;33m"
local dblue = "\27[0;34m"
local dmagenta = "\27[0;35m"
local dcyan = "\27[0;36m"
local dwhite = "\27[0;37m"
local bred = "\27[31;1m"
local bgreen = "\27[32;1m"
local byellow = "\27[33;1m"
local bblue = "\27[34;1m"
local bmagenta = "\27[35;1m"
local bcyan = "\27[36;1m"
local bwhite = "\27[37;1m"

local NotSpell ={
	-- start with things we dont want to recast
	["6"]="bad"
	,["65"]="bad"
	,["66"]="bad"
	,["75"]="bad"
	,["145"]="bad"
	,["278"]="bad"
	,["288"]="bad"
	,["596"]="bad"
	,["614"]="bad"
	,["200"] = "bad"
	,["98"] = "bad"
	,["101"] = "bad"
	,["294"] = "bad"
	,["12"] = "bad"
	,["107"] = "bad"
	,["115"] = "bad"
	,["122"] = "bad"
	,["62"] = "bad"
	,["353"] = "bad"
	,["127"] = "bad"
	,["355"] = "bad"
	,["354"] = "bad"
	,["130"] = "bad"
	,["131"] = "bad"
	,["298"] = "bad"
	,["196"] = "bad"
	,["16"] = "bad"
	,["465"] = "bad"
	,["128"] = "bad"
	,["363"] = "bad"
	,["43"] = "bad"
	,["7"] = "bad"
	,["393"] = "bad"
	,["380"] = "bad"
	,["364"] = "bad"
	,["136"] = "bad"
	,["394"] = "bad"
	,["129"] = "bad"
	,["170"] = "bad"
	,["13"] = "bad"
	,["144"] = "bad"
	,["137"] = "bad"
	,["395"] = "bad"
	,["191"] = "bad"
	,["73"] = "bad"
	,["110"] = "bad"
	,["17"] = "bad"
	,["39"] = "bad"
	,["381"] = "bad"
	,["187"] = "bad"
	,["366"] = "bad"
	,["177"] = "bad"
	,["357"] = "bad"
	,["396"] = "bad"
	,["365"] = "bad"
	,["45"] = "bad"
	,["109"] = "bad"
	,["11"] = "bad"
	,["179"] = "bad"
	,["190"] = "bad"
	,["148"] = "bad"
	,["550"] = "bad"
	,["37"] = "bad"
	,["184"] = "bad"
	,["397"] = "bad"
	,["79"] = "bad"
	,["356"] = "bad"
	,["192"] = "bad"
	,["574"] = "bad"
	,["382"] = "bad"
	,["60"] = "bad"
	,["563"] = "bad"
	,["47"] = "bad"
	,["358"] = "bad"
	,["173"] = "bad"
	,["52"] = "bad"
	,["150"] = "bad"
	,["383"] = "bad"
	,["3"] = "bad"
	,["398"] = "bad"
	,["359"] = "bad"
	,["367"] = "bad"
	,["460"] = "bad"
	,["172"] = "bad"
	,["384"] = "bad"
	,["163"] = "bad"
	,["379"] = "bad"
	,["346"] = "bad"
	,["233"] = "bad"
	,["399"] = "bad"
	,["145"] = "bad"
	,["368"] = "bad"
	,["347"] = "bad"
	,["373"] = "bad"
	,["30"] = "bad"
	,["454"] = "bad"
	,["360"] = "bad"
	,["85"] = "bad"
	,["331"] = "bad"
	,["348"] = "bad"
	,["385"] = "bad"
	,["166"] = "bad"
	,["8"] = "bad"
	,["374"] = "bad"
	,["352"] = "bad"
	,["234"] = "bad"
	,["386"] = "bad"
	,["400"] = "bad"
	,["84"] = "bad"
	,["375"] = "bad"
	,["87"] = "bad"
	,["453"] = "bad"
	,["387"] = "bad"
	,["401"] = "bad"
	,["362"] = "bad"
	,["350"] = "bad"
	,["549"] = "bad"
	,["369"] = "bad"
	,["83"] = "bad"
	,["402"] = "bad"
	,["388"] = "bad"
	,["376"] = "bad"
	,["231"] = "bad"
	,["370"] = "bad"
	,["472"] = "bad"
	,["349"] = "bad"
	,["389"] = "bad"
	,["371"] = "bad"
	,["403"] = "bad"
	,["165"] = "bad"
	,["232"] = "bad"
	,["377"] = "bad"
	,["404"] = "bad"
	,["390"] = "bad"
	,["405"] = "bad"
	,["351"] = "bad"
	,["473"] = "bad"
	,["372"] = "bad"
	,["391"] = "bad"
	,["592"] = "bad"
	,["86"] = "bad"
	,["328"] = "bad"
	,["591"] = "bad"
	,["95"] = "bad"
	,["320"] = "bad"
	,["593"] = "bad"
	,["539"] = "bad"
	,["392"] = "bad"
	,["406"] = "bad"
	,["161"] = "bad"
	,["378"] = "bad"
	,["361"] = "bad"
	,["541"] = "bad"
	--,["6"]="bad"
	-- list of skills we invoke, this converts the sn to skill name
	,["104"]="chameleon"
	,["120"]="heighten"
	,["133"]="shadow"
	,["211"]="berserk"
	,["226"]="trace"
	,["306"]="hide"
	,["311"]="sneak"
	,["496"]="aggrandize"
	,["554"]="nimble"
	,["601"]="quickstab"
	,["615"]="precision"
	-- ,["104"]="chameleon"
}

local Recoveries = {
	["13"] = "c 513" --huntmaster
	,["50"] = "quickstab"
	,["58"] = "precision"
	--,["50"] = ""
}

local failureTable = {
	["1"] ="Regular fail, lost concentration.\n",
	["2"] ="Already affected.\n",
	["3"] ="Cast blocked by a recovery.",
	["4"] ="Not enough mana.\n",
	["5"] ="You are in a nocast room.\n",
	["6"] ="Fighting or other 'can't concentrate'\n",
	["7"] ="NOT USED\n",
	["8"] ="You don't know the spell.\n",
	["9"] ="You tried to cast self only on other.\n",
	["10"] ="You are resting / sitting.\n",
	["11"] ="Skill/Spell has been disabled.\n",
	["12"] ="Not enough moves.\n",
}

local Status = "0"
local QueuedSpells = {}
local DebugMode = 0

function AffectFail(name, line, FailData)
	SN = FailData["1"]
	Target = FailData["2"]
	FailReason = FailData["3"]
	Recovery = FailData["4"]
	if NotSpell[SN] == "bad" or
		(FailReason ~= "6" and FailReason ~= "10" and FailReason ~= "1") or
		Target == "1" then
		Note(string.format("%sFailed and we can't queue this ability!%s\n", dred, dwhite))
		Note(string.format("%sFailReason is: %s%s%s\n", dwhite, bwhite, failureTable[FailReason], dwhite))
		return
	elseif FailReason == "6" then
		QueueSpell(SN)
	elseif ((Status == "3") or (Status == "8")) then
		CastSpell(SN)
	else
		Note(string.format("%sQueueing that for later%s\n", bwhite, dwhite))
		QueueSpell(SN)
	end

end

function AffectEnds(name, line, SkillNum)
	SN = SkillNum["1"]
	if NotSpell[SN] == "bad" then
		return
	elseif ((Status == "3") or (Status == "8")) then
		CastSpell(SN)
	else
		Note(string.format("%sQueueing that for later%s\n", bwhite, dwhite))
		QueueSpell(SN)
	end

end

function AffectOn(name, line, SkillNum)
	--[[
	local spelltime = SkillNum["2"]
	local hours = spelltime / 3600
	local minutes = (spelltime - (60 * hours)) / 60
	local seconds = (spelltime % 60) % 60
	Note(string.format("Acknowledge casting of %s, it will last for %2dh%02dm%02ds\n",
	SkillNum["1"], hours, minutes, seconds))
	--]]
end

function RecoveryEnds(name, line, Recovery)
	Skill = Recovery["1"]
	if Skill ~= nil then
		SendToServer(Skill)
	else
		Note(string.format("%sWe have no way to handle this recovery: %s%s%s\n", dred, bred, Skill, dwhite))
	end

end

function UpdateStatus(NewStatus)
	if NewStatus.state ~= Status then
		if DebugMode ~= 0 then
			Note(string.format("%sChecking Status Change was: %s%s %snow is: %s%s.%s\n",
			dyellow, byellow, Status, dyellow, byellow, NewStatus.state, dwhtie))
		end
		Status = NewStatus.state
		if Status == "3" then
			Note(string.format("%sAble to now activate queued spells and skills.%s\n", bgreen, dwhite))
			RunQueuedSpells()
		end

	end

end

function ToggleSpellup(NewState)
	NewState = string.lower(NewState)
	if (NewState == "off") then
		State = false
		Note(string.format("%sTurning spellup triggers off!%s\n", bred, dwhite))
	else
		State = true
	end

	EnableTriggerGroup("ReSkill", State)
	Note(NewState.. "\n")
end

function QueueSpell(SN)
	if NotSpell[SN] ~= nil then
		table.insert(QueuedSpells,NotSpell[SN])
	else
		table.insert(QueuedSpells,"c "..SN)
	end

end

function CastSpell(SN)
	if NotSpell[SN] ~= nil then
		SendToServer(NotSpell[SN])
	else
		SendToServer("c "..SN)
	end

end

function RunQueuedSpells()
	for i,QueuedSpell in pairs(QueuedSpells) do
		SendToServer(QueuedSpell)
	end

	QueuedSpells = {}
end

function DebugToggle(NewMode)
	if tonumber(NewMode) ~= 0 then
		DebugMode = 1
	else
		DebugMode = 0
	end

end

function OnBackgroundStartup()
	Send_GMCP_Packet("request char")
end

RegisterSpecialCommand("SpellupDebug", "DebugToggle")
RegisterSpecialCommand("sp", "ToggleSpellup")
Note(string.format("%sAuto Spellup Plugin installed.%s\n", bgreen, dwhite))

