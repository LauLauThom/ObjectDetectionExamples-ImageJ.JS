/*
 * This macro demonstrates the rough localization of multi-cellular embryos using local intensity minimum
 * The RGB image is first converted to grayscale, and smoothed using a gaussian filter
 * The center of each embryos is then localized as local intensity minimum from this smoothed grayscale image
 * Finally for each center a circular selection of predefined dimensions is generated, to roughly outline each embryo
 * and the resulting ROI are overlaid on the original image
 */
run("Embryos (42K)");
//open("C:/Users/Laurent Thomas/Desktop/embryos.jpg");

run("Duplicate...", "title=Gray");
run("32-bit");
run("Gaussian Blur...", "sigma=10");
run("Find Maxima...", "prominence=8 light output=[Point Selection]"); // light background means the find maxima is actually a find minima
roiManager("add")

roi = roiManager("Select", 0); 
Roi.getCoordinates(listX, listY); // get the X,Y-coordinates of local minima 

// Make a 60x60 circle centered on each intensity minima, to roughly outline the embryos
width  = 60
height = 60
for (i=0; i<listX.length; i++){
	x0 = listX[i];
	y0 = listY[i];
	makeOval(x0-width/2, y0-height/2, width, height);
	roiManager("add");
	roiManager("draw");
}

selectImage("embryos.jpg");
roiManager("show all");