local currentPlayers = player.GetAll() -- change to GetHumans later

local getSteamId = Entity(1):SteamID64()

local plyInfo = player.GetBySteamID64(getSteamId)

local plyCount = player.GetCount()

for i = 1, plyCount do
  print(currentPlayers[i], currentPlayers[i]:GetRole())
end


local function getAllRoles(currentPlayers)
  print("Error: getAllRoles is currently not supported")
end
