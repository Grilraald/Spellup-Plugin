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
  --,["6"]="bad"
  -- list of skills we invoke, this converts the sn to skill name
  ,["104"]="chameleon"
  ,["120"]="heighten"
  ,["133"]="shadow"
  ,["211"]="berserk"
  ,["306"]="hide"
  ,["311"]="sneak"
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

local Status = "0"
local QueuedSpells = {}
local DebugMode = 0

function AffectFail(name, line, FailData)
  SN = FailData["1"]
  Target = FailData["2"]
  FailReason = FailData["3"]
  Recovery = FailData["4"]
  if NotSpell[SN] == "bad" or 
    (FailReason ~= "6" and FailReason ~= "10") or
    Target == "1" then
    Note(string.format("%sFailed and we can't queue this ability!%s\n", dred, dwhite))
    Note(string.format("%sFailReason is:%s%s\n", bwhite, tostring(FailReason), dwhite))
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

