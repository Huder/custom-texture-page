# custom-texture-page
Custom texture page on constant grid for GameMaker Studio 2

Why Create a Custom Texture Page System?

GameMaker Studio 2 does not place sprites generated using the sprite_create* family of functions onto an existing texture page. Instead, it creates a new texture page with only that single sprite on it. This causes significant issues with texture swaps during gameplay, especially when a large number of such sprites are created.

Frequent texture swaps can quickly degrade game performance, which is particularly noticeable on weaker platforms like the Nintendo Switch. Since each texture swap requires the GPU to load a new texture into memory, excessive swapping can lead to frame drops and increased rendering times.

The solution to this problem is to implement a custom texture page system.

My implementation has some limitations. The grid is fixed, and it only works for the first image_index of a given sprite.
