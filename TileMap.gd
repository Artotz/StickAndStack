extends TileMap

const map = [[1,1,1,1,1,1,1,1,1,1,1,1],
			 [1,0,0,0,0,0,0,0,0,0,0,1],
			 [1,0,0,0,0,0,0,0,0,0,0,1],
			 [1,0,0,0,0,0,0,0,0,0,0,1],
			 [1,0,0,0,1,0,1,0,0,0,0,1],
			 [1,0,0,0,0,0,0,0,0,0,0,1],
			 [1,0,0,0,0,0,0,0,0,0,0,1],
			 [1,0,0,0,0,0,0,0,0,0,0,1],
			 [1,1,1,1,1,1,1,1,1,1,1,1]]



# Called when the node enters the scene tree for the first time.
func _ready():	
	for i in range(map.size()):
		for j in range(map[0].size()):
			set_cell(0, Vector2i(j,i), map[i][j]-1, Vector2i(0,0))
			
#	print(self.get_cell_source_id(0, Vector2i(1,1)))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

