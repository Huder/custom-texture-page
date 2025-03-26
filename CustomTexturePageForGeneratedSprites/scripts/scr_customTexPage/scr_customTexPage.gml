/// @desc Umieszna nowy sprite na custom texture page
function sprite_page_set(hexSurface, sprXoffset, sprYoffset)
{
	var image = hexSurface;
	var ox = sprXoffset;
	var oy = sprYoffset;
	
	with (oCustomTexturePageControler)
	{
		// sprawdzanie czy texture page jest zapelniony jak tak to tworzymy nowy
		if ( texPageSprItems[texPageNum] == texPageMaxItems )
		{
				texPageNum++;
				global.texPageSprIndex[texPageNum] = undefined;
				texPageSprItems[texPageNum] = 0;
		}
		
		if ( !surface_exists(texPageSurf) )
		{
			texPageSurf = surface_create(texPageSize, texPageSize);
		}
			
		// umieszczamy obrazek hexa na texture pagu
		if ( global.texPageSprIndex[texPageNum] == undefined ) // texture page jest pusty i nie ma jeszcze sprite indexu wiec go stworzymy
		{
			
			surface_set_target(texPageSurf);
			draw_clear_alpha(0, 0);
			draw_surface(image, 0, 0); // rysujemy hexa na pierwszej pozycji
			surface_reset_target();
			texPageSprItems[texPageNum]++;
			global.texPageSprIndex[texPageNum] = sprite_create_from_surface(texPageSurf, 0, 0, texPageSize, texPageSize, 0, 0, 0, 0); 
			
			global.hex[global.hexIndex, HEX.pageIndex] = texPageNum;
			global.hex[global.hexIndex, HEX.pageU]= 0;
			global.hex[global.hexIndex, HEX.pageV] = 0;
			global.hex[global.hexIndex, HEX.xoffset] = ox;
			global.hex[global.hexIndex, HEX.yoffset] = oy;
			global.hexIndex++;
		}
		else
		{		
			surface_set_target(texPageSurf);
			draw_clear_alpha(0, 0);
			draw_sprite(global.texPageSprIndex[texPageNum], 0, 0, 0);
			
			var index = texPageSprItems[texPageNum];
			var uu = index mod texPageMaxColumns;
			var vv = index div texPageMaxColumns;
			vv = vv mod texPageMaxRows;			
			
			draw_surface(image, uu*sprW, vv*sprH); 
			surface_reset_target();
			sprite_delete(global.texPageSprIndex[texPageNum]);
			texPageSprItems[texPageNum]++;
			global.texPageSprIndex[texPageNum] = sprite_create_from_surface(texPageSurf, 0, 0, texPageSize, texPageSize, 0, 0, 0, 0); 
			
			global.hex[global.hexIndex, HEX.pageIndex] = texPageNum;
			global.hex[global.hexIndex, HEX.pageU] = uu*sprW;
			global.hex[global.hexIndex, HEX.pageV] = vv*sprH;
			global.hex[global.hexIndex, HEX.xoffset] = ox;
			global.hex[global.hexIndex, HEX.yoffset] = oy;
			global.hexIndex++;
		}		
	}
}

/// @desc rysuje sprite z texure pagu
function draw_sprite_page(hexIndex, X, Y, scaleX, scaleY, rot, color, alpha)
{
	var index = hexIndex;
	var pageIndex = global.hex[index, HEX.pageIndex];
	var U = global.hex[index, HEX.pageU];
	var V = global.hex[index, HEX.pageV];
	var ox = global.hex[index, HEX.xoffset];
	var oy = global.hex[index, HEX.yoffset];
	
	var mat = matrix_build(-ox, -oy, 0, 0, 0, 0, 1, 1, 1);
	var mat2 = matrix_build(X, Y, 0, 0, 0, rot, scaleX, scaleY, 1);

	matrix_set(matrix_world, matrix_multiply(mat, mat2));
		draw_sprite_part_ext(global.texPageSprIndex[pageIndex], 0, U, V, sprW, sprH, 0, 0, 1, 1, color, alpha);
	matrix_set(matrix_world, matrix_build_identity());
}

/// @desc usuwa texture page'y
function sprite_page_flush()
{
	with (oCustomTexturePageControler)
	{
		for ( var i = 0; i < texPageNum+1; i++ )		
		{
			sprite_delete(global.texPageSprIndex[i]);
			global.texPageSprIndex[i] = undefined;
			texPageSprItems[i] = 0;
		}
		texPageNum = 0;
		global.hexIndex = 0;
		surface_free(global.hexSurf);
		surface_free(texPageSurf);
	}
}