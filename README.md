# Cave VR terrain editor
**See [demo video](https://www.youtube.com/watch?v=BsqFC-Vi3zI).**

This runs on the Vive.  Download godot from http://tokisan.com/godot-binaries/ (github at [here](https://github.com/tinmanjuggernaut/voxelgame)) which have https://github.com/Zylann/godot_voxel already compiled in.
"Godot_v3.2.2rc+cd8d43_win64.exe"  

Ignore a couple of dependencies for target meshes.  On Assetlib tab download -- and install -- OpenVR Module, Oculus Quest Toolkit and Godot XR Tools - AR and VR helper library.

Can be made to work (done with Tag v0.1) on the Oculus Quest with a lot of hassle and building from sources to create the correct android export templates; instructions are as for https://github.com/NeoSpark314/VoxelWorksQuest

Right hand controller: fly around by squeezing grip button and pulling on trigger while pointing in the direction you want to go.

Left hand controller: dig or make by holding trigger to remove (blue) add (red) a sphere of material.  Cycle the modes with the grip button.  Change size and distance of the delete sphere by clicking top bottom left or right on the thumb touchpad.

You can go off the edge of the world, fly underneath and see the cave from the outside.

Other bits of geometry (apart from the terrain) are measured cave passages.  The idea is you would carve out and decorate cave passages in VR in a co-editable shared space (like OpenStreetMaps) using those measurements as a guideline and any notes that you have scanned off paper to make available in VR world in a booklet.

See this video for an explanation of cave surveying https://www.youtube.com/watch?v=OJus_6fj19U&feature=youtu.be  (Most cave exploration is not underwater, but this just happens to be a good video explaining the process.)

![screenshot](/screenshot_rough.jpg)

An upgrade to the voxel terrain model will need to be undertaken for this whole idea to work.  
https://github.com/Zylann/godot_voxel/issues/144

