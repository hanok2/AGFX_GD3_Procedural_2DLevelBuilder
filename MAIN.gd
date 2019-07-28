extends Node2D


export (Vector2) var roomCounts = Vector2(13,10)

var levelBuilder:SceneBuilderTilemap = null
var tilesetBuilder =  TilesetBuilder.new()


func _ready():
	
	# create Tilesets
	self.PrepareTilesets()
	
	# attach tileset to tilemap
	#$"Tilemaps/L0-BACK".set_tileset(load ())
	
	# create builder
	self.levelBuilder = SceneBuilderTilemap.new()
	
	# add patterns for WALLS
	self.levelBuilder.AddWallPattern(load("res://Sprites/Patterns/WALL-0.png"))
	self.levelBuilder.AddWallPattern(load("res://Sprites/Patterns/WALL-1.png"))
	self.levelBuilder.AddWallPattern(load("res://Sprites/Patterns/WALL-2.png"))
	self.levelBuilder.AddWallPattern(load("res://Sprites/Patterns/WALL-3.png"))
	
	# add patterns for PLATFORMS
	self.levelBuilder.AddPlatformPattern(load("res://Sprites/Patterns/PLATFORMS-001.png"))
	self.levelBuilder.AddPlatformPattern(load("res://Sprites/Patterns/PLATFORMS-002.png"))
	self.levelBuilder.AddPlatformPattern(load("res://Sprites/Patterns/PLATFORMS-003.png"))
	
	# add patterns for LADDERS
	self.levelBuilder.AddLadderPattern(load("res://Sprites/Patterns/LADDER-001.png"))
	self.levelBuilder.AddLadderPattern(load("res://Sprites/Patterns/LADDER-002.png"))
	self.levelBuilder.AddLadderPattern(load("res://Sprites/Patterns/LADDER-003.png"))
	
	# assign scene tilemap
	#self.levelBuilder.SetTargetTilemap($"Tilemaps/L0-BACK",SceneBuilderTilemap.eLayerType.BACKGROUND)
	self.levelBuilder.SetTargetTilemap($"Tilemaps/L1-BASE",SceneBuilderTilemap.eLayerType.BASE)
	#self.levelBuilder.SetTargetTilemap($"Tilemaps/L2-FRONT",SceneBuilderTilemap.eLayerType.FOREGROUND)
	
	# add pattern color definition
	self.levelBuilder.AddScanColor(SceneBuilderTilemap.eLayerType.BASE,0,SceneBuilderTilemap.ePattern.WALL,Color.black)
	self.levelBuilder.AddScanColor(SceneBuilderTilemap.eLayerType.BASE,0,SceneBuilderTilemap.ePattern.PLATFORM,Color.black)
	self.levelBuilder.AddScanColor(SceneBuilderTilemap.eLayerType.BASE,0,SceneBuilderTilemap.ePattern.LADDER,Color.green)
	self.levelBuilder.AddScanColor(SceneBuilderTilemap.eLayerType.BASE,0,SceneBuilderTilemap.ePattern.ONEWAYPLATFORM,Color.blue)
	
	# initialzie builder
	self.levelBuilder.Initialize(roomCounts,2019,false)
	
	# create minimap
	self.levelBuilder.GenerateMinimap()
	$Tilemaps/Minimap.set_texture(Utils.CreateTextureFromImage(self.levelBuilder.minimap))
	
	# build
	self.levelBuilder.Build()
	
	
func PrepareTilesets()->void:
	var images_json = { 		
		"0" : {"name": "BACK" ,"width":16,"height":16, "src":"res://Sprites/AutoTile_0.png"},
		"1" : {"name": "WALL" ,"width":16,"height":16, "src":"res://Sprites/AutoTile_1.png"}
	}
	Utils.SaveJSON("res://TilesetImages.data",images_json,true)
	tilesetBuilder.BuildFromFile(Utils.LoadJSON("res://TilesetImages.data"),"BASE-ProceduralTilesets.tres")
	pass