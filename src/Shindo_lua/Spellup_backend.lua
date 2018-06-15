local NotSpell ={
  -- start with things we dont want to recast
  ["6"]="bad"
  ,["65"]="bad"
  ,["66"]="bad"
  , ["75"]="bad"
  ,["278"]="bad"
  ,["596"]="bad"
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
  -- ,["104"]="hide"
}

local Recoveries = {
  ["50"] = "quickstab"
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
    Note("Failed and we can't queue this ability.\n")
    return
  elseif FailReason == "6" then
    QueueSpell(SN)
  elseif ((Status == "3") or (Status == "8")) then
    CastSpell(SN)
  else
    Note("Bad Status for casting\n")
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
    Note("Bad Status for casting\n")
    QueueSpell(SN)
  end
end

function AffectOn(name, line, SkillNum)
  Note("Acknowledge casting of "..SkillNum["1"]
  ..", duration is "..SkillNum["2"].." seconds\n")
end

function RecoveryEnds(name, line, Recovery)
  Skill = Recovery["1"]
  if Skill ~= nil then
    SendToServer(Skill)
  else
    Note("We have no way to handle "..Recovery["1"].."\n")
  end
end

function UpdateStatus(NewStatus)
  if DebugMode ~= 0 then 
    Note(string.format("Checking Status change was: %s now is: %s.\n"),
    Status, NewStatus.state) 
  end
  if NewStatus.state ~= Status then 
    Status = NewStatus.state
    if Status == "3" then
      Note("Able to now activate queued spells and skills\n")
      RunQueuedSpells()
    end
  end
end

function ToggleSpellup(NewState)
  NewState = string.lower(NewState)
  if (NewState == "off") then 
    State = false
    Note("turning triggers off\n") 
  else State = true 
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
Note("Auto Spellup functions installed.\n")

