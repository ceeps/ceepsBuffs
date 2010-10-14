BUFF_FLASH_TIME_ON = 0.8;
BUFF_FLASH_TIME_OFF = 0.8;
BUFF_MIN_ALPHA = 0.70;

local TEX1 = [=[Interface\AddOns\ceepsBuffs\media\Gloss]=]
local TEX2 = [=[Interface\AddOns\ceepsBuffs\media\Border]=]
local FONT = [=[Interface\AddOns\ceepsBuffs\media\neuropol.ttf]=]

local addon = CreateFrame("Frame")
local _G = getfenv(0)

addon:SetScript("OnEvent", function(self, event, ...)
    local unit = ...;
    
    if(event == "PLAYER_ENTERING_WORLD") then
        ConsolidatedBuffs:ClearAllPoints()
        ConsolidatedBuffs:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 260, -10)
        addon:runthroughicons()
    end
    
    if (event == "UNIT_AURA") then
        if (unit == PlayerFrame.unit) then
            addon:runthroughicons()
        end
    end
end)

function addon:runthroughicons()
    local i = 1
    while _G["BuffButton"..i]
    do
        addon:checkgloss("BuffButton"..i,1)
        i = i + 1
    end
    
    i = 1
    while _G["DebuffButton"..i]
    do
        addon:checkgloss("DebuffButton"..i,2)
        i = i + 1
    end
    
    i = 1
    while _G["TempEnchant"..i]
    do
        addon:checkgloss("TempEnchant"..i,3)
        i = i + 1
    end
end

function addon:checkgloss(name, icontype)
    local border = _G[name.."Border"]
    local icon = _G[name.."Icon"]
    local frame = _G[name]
    local gloss = _G[name.."Gloss"]
    local duration = _G[name.."Duration"]
    
    duration:SetFont(FONT, 10, "OUTLINE")
    duration:ClearAllPoints()
    duration:SetPoint("TOP", frame, "BOTTOM", 0, 0)
    
    if not gloss then
    
        local glossframe = CreateFrame("FRAME", name.."Gloss", frame)
        glossframe:SetAllPoints(frame)
        
        local tex = frame:CreateTexture(name.."GlossTexture", "ARTWORK")
        tex:SetTexture(TEX1)
        tex:SetPoint("TOPRIGHT", glossframe, 4, 4)
        tex:SetPoint("BOTTOMLEFT", glossframe, -4, -4)
        tex:SetTexCoord(0, 1, 0, 1)
        
        icon:SetTexCoord(0.03, 0.97, 0.02, 0.97)
        
        local g = frame:CreateTexture(nil, "BORDER")
        g:SetPoint("TOPRIGHT", icon, 4, 4)
        g:SetPoint("BOTTOMLEFT", icon, -4, -4)
        g:SetTexture(TEX2)
        g:SetVertexColor(0.45, 0.4, 0.4)
        
    end
    
    local btex = _G[name.."GlossTexture"]    
    
    if icontype == 2 and border then
      local red,green,blue = border:GetVertexColor();    
      btex:SetTexture(TEX1)
      btex:SetPoint("TOPRIGHT", icon, 4, 4)
      btex:SetPoint("BOTTOMLEFT", icon, -4, -4)
      btex:SetVertexColor(red*0.5,green*0.5,blue*0.5)
    
    elseif icontype == 3 and border then
      btex:SetTexture(TEX1)
      btex:SetPoint("TOPRIGHT", icon, 4, 4)
      btex:SetPoint("BOTTOMLEFT", icon, -4, -4)
      btex:SetVertexColor(0.5,0,0.5) 
    
    else
      btex:SetTexture(TEX1)
      btex:SetVertexColor(0.45,0.4,0.4) 
    end  
    
    if border then border:SetAlpha(0) end

end

SecondsToTimeAbbrev = function(time)
    local hr, m, s, text
    if time <= 0 then text = ""
    elseif(time < 3600 and time > 60) then
      hr = floor(time / 3600)
      m = floor(mod(time, 3600) / 60 + 1)
      text = format("%dm", m)
    elseif time < 60 then
      m = floor(time / 60)
      s = mod(time, 60)
      text = (m == 0 and format("%ds", s))
    else
      hr = floor(time / 3600 + 1)
      text = format("%dh", hr)
    end
    return text
end

addon:RegisterEvent("UNIT_AURA");
addon:RegisterEvent("PLAYER_ENTERING_WORLD");