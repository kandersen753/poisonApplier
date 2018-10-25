local CreateFrame = CreateFrame
PoisonApplier = { }
PoisonApplier.eventHandler = CreateFrame("Frame")
PoisonApplier.eventHandler:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")


print('Poison Alert Loaded the alert sound.')

PoisonApplier.eventHandler:SetScript("OnEvent",function(self, event, ...)
  
  --gets the player current specialization
  local currentSpec = GetSpecialization()
  local currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or "None"
  
  --ensures player is on an assassination rogue
  if currentSpecName == "Assassination" then
    --poisons are assumed to be off at the start of arena
    local deadlyPoison = false
    local cripplingPoison = false
    
    print ("arena prep opponent specializations called")
    
    --loops through all buffs and gets the indexed buffs name
    for i=1, 40 do 
      local buffName=UnitBuff("player", i)
      
      --checks to see if the current buff is deadly poison
      if buffName == "Deadly Poison" then 
        --change deadly poison flag to true
        deadlyPoison = true
      end
      
      --checks to see if the current buff is crippling poison
      if buffName == "Crippling Poison" then
        --change crippling poison flag to true
        cripplingPoison = true
      end
    end
    if deadlyPoison == false or cripplingPoison == false then
      --remind player that deadly poison and crippling poison need to be applied
      RaidNotice_AddMessage( RaidBossEmoteFrame, "APPLY DEADLY AND CRIPPLING POISON!!", ChatTypeInfo["RAID_BOSS_EMOTE"])
      PlaySoundFile("Interface\\AddOns\\PoisonApplier\\sounds\\alert.wav", "Master")
    end
  end
end)
