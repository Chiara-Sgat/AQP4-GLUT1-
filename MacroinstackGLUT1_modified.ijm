//Calculate mean gray value of AQP4(PFFnew) using AQP4 as a mask.

setOption("BlackBackground", false);
path=getDirectory("Select an image");
list=getFileList(path);

for (i = 0; i < list.length; i++) {
	if (endsWith(list[i], ".tif")) {
		open(path+File.separator+list[i]);
	title=getList("image.titles");
	rename("AQP4red");
	run("Duplicate...", "title=AQP4seg duplicate");
	run("Enhance Contrast...", "saturated=0.2 normalize process_all");
	run("Median 3D...", "x=2 y=2 z=2");
	run("Subtract Background...", "rolling=20 stack");
	setAutoThreshold("Triangle dark stack");
	run("Convert to Mask", "method=Triangle background=Dark");
	run("Set Measurements...", "area mean integrated display redirect=AQP4red decimal=2");
	run("Analyze Particles...", "size=10-Infinity show=Masks display clear stack");
	selectWindow("Results");
	saveAs("Results", path+File.separator+list[i]+"_resultsnotsummirized.csv");
	run("Close");
	run("Close All");
	
}
}