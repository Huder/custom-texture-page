/// @description generujemy sprite

if ( spriteCreated == false )
{
	
	if ( !surface_exists(global.hexSurf) )
	{
		global.hexSurf = surface_create(sprW, sprH);
	}

	// generowanie grafiki
	surface_set_target(global.hexSurf);
		draw_clear_alpha(0, 0);
		draw_sprite(sprite_index, image_index, sprOx, sprOy);
		gpu_set_blendmode(bm_add);
			repeat(10)
			{
				draw_circle_color(sprW/2+random_range(-60, 60), sprH/2+random_range(-60, 60), random_range(16, 32), random(#FFFFFF), random(#FFFFFF), 0);
			}	
		gpu_set_blendmode(bm_normal);	
	surface_reset_target();

	// umieszanie grafiki na texture pagu 
	sprIndex = global.hexIndex;
	sprite_page_set(global.hexSurf, sprOx, sprOy);
	
	spriteCreated = true;
}