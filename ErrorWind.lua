--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER 

designed using localmaze gui creator
]=]


local CollectionService = game:GetService("CollectionService");
local G2L = {};

G2L["ScreenGui"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["ScreenGui"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;

CollectionService:AddTag(G2L["ScreenGui"], [[main]]);

G2L["ErrWindow"] = Instance.new("Frame", G2L["ScreenGui"]);
G2L["ErrWindow"]["ZIndex"] = 4;
G2L["ErrWindow"]["BorderSizePixel"] = 0;
G2L["ErrWindow"]["BackgroundColor3"] = Color3.fromRGB(31, 18, 17);
G2L["ErrWindow"]["Size"] = UDim2.new(0, 658, 0, 320);
G2L["ErrWindow"]["Position"] = UDim2.new(0.5, -322, 0, -24);
G2L["ErrWindow"]["Name"] = [[ErrWindow]];
G2L["ErrWindow"]["BackgroundTransparency"] = 0.2;


G2L["UICorner"] = Instance.new("UICorner", G2L["ErrWindow"]);



G2L["UIStroke"] = Instance.new("UIStroke", G2L["ErrWindow"]);
G2L["UIStroke"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["UIStroke"]["Thickness"] = 3;
G2L["UIStroke"]["Color"] = Color3.fromRGB(255, 223, 190);


G2L["Header"] = Instance.new("Frame", G2L["ErrWindow"]);
G2L["Header"]["BorderSizePixel"] = 0;
G2L["Header"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["Header"]["Size"] = UDim2.new(0, 658, 0, 44);
G2L["Header"]["Position"] = UDim2.new(0, 2, 0, 0);
G2L["Header"]["Name"] = [[Header]];
G2L["Header"]["BackgroundTransparency"] = 1;


G2L["Title_Store"] = Instance.new("TextLabel", G2L["Header"]);
G2L["Title_Store"]["BorderSizePixel"] = 0;
G2L["Title_Store"]["TextSize"] = 36;
G2L["Title_Store"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["Title_Store"]["FontFace"] = Font.new([[rbxasset://fonts/families/Oswald.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["Title_Store"]["TextColor3"] = Color3.fromRGB(255, 223, 190);
G2L["Title_Store"]["BackgroundTransparency"] = 1;
G2L["Title_Store"]["Size"] = UDim2.new(0, 86, 0, 44);
G2L["Title_Store"]["Text"] = [[Error!]];
G2L["Title_Store"]["Name"] = [[Title_Store]];


G2L["CloseButton"] = Instance.new("ImageButton", G2L["Header"]);
G2L["CloseButton"]["BorderSizePixel"] = 0;
G2L["CloseButton"]["BackgroundTransparency"] = 1;
G2L["CloseButton"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["CloseButton"]["ImageColor3"] = Color3.fromRGB(255, 223, 190);
G2L["CloseButton"]["Image"] = [[rbxassetid://2195446979]];
G2L["CloseButton"]["Size"] = UDim2.new(0, 52, 0, 52);
G2L["CloseButton"]["Name"] = [[CloseButton]];
G2L["CloseButton"]["Position"] = UDim2.new(0, 596, 0, 4);

return G2L["ScreenGui"], require;