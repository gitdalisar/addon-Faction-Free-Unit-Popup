--[[
Faction Free Unit Popup Addon for use either with the Faction Free Module or standalone if you are 
leveraging the AllowTwoSide settings within the worldserver.conf file. There are some UI limitations
with the default UnitPopup.lua used by the wow client. In order to open up the UI and allow only the
options that work, while supressing the one that will cause the addon failure, this addon was created.

LUA is part of the mod-Faction-Free-Unit-Popup-Addon AzerothCore module hosted at:
https://github.com/gitdalisar/mod-Faction-Free

Maintained by GitDalisar
]]--



-- Local definition to be used and set up the events. Will be working around the event of targeting a unit.
local OppositeFactionMenuMod = CreateFrame("Frame")
OppositeFactionMenuMod:RegisterEvent("UNIT_TARGET")
OppositeFactionMenuMod:SetScript("OnEvent", function(_, event, ...) OppositeFactionMenuMod[event](OppositeFactionMenuMod, ...) end)

--[[
    Build menu list items out as well as ensure no conflicts are present. Start by removing any previously
    added Invite/Whisper options, otherwise sequential right clicks may have artifacts left behind. Remove
    the Set Focus option as we are touching the menu and this introduces UI taint where setting focus is 
    "targeting" and thus not allowed by Addons. Finally we add in the two new options that will work and
    compliment the "AllowTwoSide" settings within worldserver.conf.
]]--
function OppositeFactionMenuMod:UNIT_TARGET(unitid)
    if unitid == "player" and UnitExists("target") then 
        if UnitFactionGroup("target") ~= UnitFactionGroup("player") and UnitIsPlayer("target") then 
            for i = #UnitPopupMenus["PLAYER"], 1, -1 do  
                local option = UnitPopupMenus["PLAYER"][i]
                if option == "Invite" or option == "Whisper" or option == "SET_FOCUS" then
                    tremove(UnitPopupMenus["PLAYER"], i)
                end
            end
            tinsert(UnitPopupMenus["PLAYER"], #UnitPopupMenus["PLAYER"] - 1, "Invite")
            tinsert(UnitPopupMenus["PLAYER"], #UnitPopupMenus["PLAYER"] - 2, "Whisper")
        end
    end
end

--[[
    Define the text and links that are now tied to those two new menu options. Starting with Invite we will 
    use InviteUnit to make this happen. For Whipers we will use ChatFrame_SendTell to populate your chat
    window with the target's name.
]]--
UnitPopupButtons["Invite"] =
{
    text = "Invite",
    dist = 0,
    func = function() InviteUnit(UnitName("target")) end
}
UnitPopupButtons["Whisper"] =
{
    text = "Whisper",
    dist = 0,
    func = function() ChatFrame_SendTell(UnitName("target")) end
}

-- Finally we will define a function and register it to call the appropriate functions we defined above if they are selected. 
function Assignfunchook(dropdownMenu, which, unit, name, userData, ...)
    for i = 1, UIDROPDOWNMENU_MAXBUTTONS do
        local button = _G["DropDownList"..UIDROPDOWNMENU_MENU_LEVEL.."Button"..i];
        if button.value == "Invite" or button.value == "Whisper" then
            button.func = UnitPopupButtons[button.value].func
        end
    end
end
hooksecurefunc("UnitPopup_ShowMenu", Assignfunchook)