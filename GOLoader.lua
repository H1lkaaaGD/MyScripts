if not game:IsLoaded() then
  game.Loaded:wait()
end
if game.PlaceId == 6839171747 then
	local ReplicatedStorage = game:GetService("ReplicatedStorage");
	local Floor = ReplicatedStorage:WaitForChild("Floor");
	if Floor.value == "Garden" then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/H1lkaaaGD/MyScripts/refs/heads/main/main.lua"))();
	end
end
