-- Initialize the role count table
local roleCount = {}

-- Print the round count and role count to the player's chat at the start of each round
hook.Add("TTTBeginRound", "PrintRoundAndRoleCount", function()
  for _, ply in ipairs(player.GetAll()) do
    local steamID = ply:SteamID()
    local roundCount = tonumber(ply:GetPData("round_count", 0))
    local innocentCount = tonumber(ply:GetPData("innocent_count", 0))
    local detectiveCount = tonumber(ply:GetPData("detective_count", 0))
    local traitorCount = tonumber(ply:GetPData("traitor_count", 0))
    local message = "You have played " ..
        roundCount ..
        " rounds on this server. Role count: Innocent - " ..
        innocentCount .. ", Detective - " .. detectiveCount .. ", Traitor - " .. traitorCount .. "."
    ply:PrintMessage(HUD_PRINTTALK, message)
    ply:PrintMessage(HUD_PRINTCONSOLE, message)
  end
end)

-- Increment the role count when a player's role changes
hook.Add("TTTUpdatePlayer", "IncrementRoleCount", function(ply)
  local role = ply:GetRole()
  local roleString = ROLE_STRINGS[role]
  if role ~= ROLE_INNOCENT then
    roleCount[ply:SteamID()] = roleCount[ply:SteamID()] or {}
    roleCount[ply:SteamID()][roleString] = (roleCount[ply:SteamID()][roleString] or 0) + 1
    ply:SetPData(roleString:lower() .. "_count", roleCount[ply:SteamID()][roleString])
  end
end)

-- Increment the round count for each player
hook.Add("TTTEndRound", "IncrementRoundCount", function(result)
  for _, ply in ipairs(player.GetAll()) do
    local roundCount = tonumber(ply:GetPData("round_count", 0))
    ply:SetPData("round_count", roundCount + 1)
  end
end)

-- Send private chat message to player with their round count and role count at the start of each round
hook.Add("TTTBeginRound", "SendPrivateMessage", function()
  for _, ply in ipairs(player.GetAll()) do
    local steamID = ply:SteamID()
    local roundCount = tonumber(ply:GetPData("round_count", 0))
    local innocentCount = tonumber(ply:GetPData("innocent_count", 0))
    local detectiveCount = tonumber(ply:GetPData("detective_count", 0))
    local traitorCount = tonumber(ply:GetPData("traitor_count", 0))
    local message = "You have played " ..
        roundCount ..
        " rounds on this server. Role count: Innocent - " ..
        innocentCount .. ", Detective - " .. detectiveCount .. ", Traitor - " .. traitorCount .. "."
    ply:PrintMessage(HUD_PRINTCENTER, message)
  end
end)
