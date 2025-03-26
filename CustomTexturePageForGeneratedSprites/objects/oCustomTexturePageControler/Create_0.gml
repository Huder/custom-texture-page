/// @description
texPageSize = 2048; // custom texture page size
texPageSurf = surface_create(texPageSize, texPageSize);

sprW = sprite_get_width(sHex);
sprH = sprite_get_height(sHex);

// siatka na texture pagu jest stala
texPageMaxColumns = (texPageSize div sprW)+1;
texPageMaxRows	  = (texPageSize div sprH)+1;
texPageMaxItems   = texPageMaxColumns*texPageMaxRows;
 
texPageNum = 0;							   // ile juz zostalo zapelnionych texture pagow
										   // tu bedą sie pojawiac sprite_index danego texture pagu
global.texPageSprIndex[texPageNum] = undefined;   // sprite_create_from_surface(texPageSurf, 0, 0, texPageSize, texPageSize, 0, 0, 0, 0); ; 
texPageSprItems[texPageNum] = 0;	       // to okresla ile spritow juz jest na danym texture pagu

enum HEX {pageIndex, pageU, pageV, xoffset, yoffset};
global.hexIndex = 0;

/*  przykladowa deklaracja spritu hexa na texture pagu
	global.hex[global.hexIndex, HEX.pageIndex] = undefined;
	global.hex[global.hexIndex, HEX.pageU]	  = undefined;
	global.hex[global.hexIndex, HEX.pageV]     = undefined;
	global.hex[global.hexIndex, HEX.xoffset]     = undefined;
	global.hex[global.hexIndex, HEX.yoffset]     = undefined;
*/
show_debug_overlay(true, true, 1.1);

global.hexSurf = surface_create(sprW, sprH);