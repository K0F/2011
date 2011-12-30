

import gifAnimation.Gif;
import processing.core.PApplet;
import processing.core.PGraphics;
import processing.core.PImage;
import sojamo.drop.DropEvent;
import sojamo.drop.SDrop;


	private static final long serialVersionUID = 5159485317982749825L;
	private boolean record;
	private PImage[] images;
	
	private final String APP_NAME = "Gifflip";
	private final String APP_SUBTITLE = "turn animated gifs into flip books";
	private final String APP_DRAG_N_DROP = "Drag'n'drop a gif file here";
	private final String APP_BOTTOM_TITLE = "a tool by 01010101 / saint-clair.net";
	private final String APP_IMAGES_PER_PAGE = "Images per page";
	private final String APP_LOOP = "Loop";
	
	private final String APP_EXPORT_MADE1 = "made with";
	private final String APP_EXPORT_MADE2 = "Gifflip";
	private final String APP_EXPORT_MADE3 = "animated gif -> flipbook         a tool by 01010101 / saint-clair.net";
	
	private final String MSG_NO_IMAGE = "\r\nNo image yet";
	private final String MSG_NOTHING_TO_EXPORT = "\r\nNothing to export, drop a file here first";
	private final String MSG_PLEASE_WAIT = "\r\nPlease wait ...";
	private final String MSG_NOT_A_GIF = "\r\nError: not an image of gif";
	private final String MSG_EXPORT_DONE = "\r\nDone: %s files exported to the output folder";
	private final String MSG_CANNOT_URL = "\r\nCannot load from URL (local image only)";
	private final String MSG_READY_TO_EXPORT = "Ready to export (%s frames)\r\nPress <space bar> to create your flip book";
	
	private String infoMsg = MSG_NO_IMAGE;
	
	private SDrop sdrop;

	private int prefLoops = 1;
	private int prefLoopsMin = 1;
	private int prefLoopsMax = 10;

	private int prefImagesPerPage = 8;
	private int prefImagesPerPageMin = 4;
	private int prefImagesPerPageMax = 10;

	private String output_folder = "Gifflip_out";
	
	private int textColor = 30;
	
	private String uid = "";
	
	public void setup() {
		size(400, 325,P2D);
                textMode(SCREEN);
		frameRate(10);
		sdrop = new SDrop(this);
                textFont(createFont("Silkscreen",8,false));
	}


	public void dropEvent(DropEvent event) {

		if (event.isURL()) {
			infoMsg = MSG_CANNOT_URL;
		}

		// if the dropped object is an image, then 
		// load the image into our PImage.
		if(event.isImage()) {
			images = Gif.getPImages(this, event.filePath());
			infoMsg = String.format(MSG_READY_TO_EXPORT, ""+images.length);
		}
		else {
			infoMsg = MSG_NOT_A_GIF;
		}
	}


	public void drawCommand(int x, int y) {
		pushMatrix();
		pushStyle();

		translate(x, y);
		noFill();

		rect(0, 0, 20, 20);
		line(5, 10, 15, 10);

		rect(20, 0, 30, 20);

		rect(50, 0, 20, 20);
		line(55, 10, 65, 10);
		line(60, 5, 60, 15);

		popStyle();
		popMatrix();		
	}

	public void draw() {
		background(230);
		
		if (record) {
			println("");
		}
		
		// Top bar gradient
		pushStyle();
		for (int i=0; i<75; i++) {
			stroke(50, 100+i*4);
			line(0,i , width, i);
		}
		popStyle();

		// Title
		pushStyle();
		int x = 20;
		int y = 35;
		fill(0, 180);
		textSize(30);
		text(APP_NAME, x, y);
		popStyle();
		
		// Subtitle
		pushStyle();
		textSize(20);
		fill(230, 220);
		text(APP_SUBTITLE, x, x+40);
		popStyle();

		// Drag and drop zone
		x = 30;
		y = 100;
		noFill();
		stroke(textColor);
		rect(x-10, y, width-40, 130);
		textSize(15);
		text(APP_DRAG_N_DROP, x, y+20);

		// Info message
		fill(textColor);
		textSize(15);
		text(infoMsg, x, y+95);

		// Buttons
		// Loops
		pushStyle();
		drawCommand(20, 250);
		fill(textColor);
		textAlign(CENTER);
		text(""+prefLoops, 55, 265);
		textAlign(LEFT);
		text(APP_LOOP, 100, 265);
		// Images per page
		drawCommand(180, 250);
		fill(textColor);
		textAlign(CENTER);
		text(""+prefImagesPerPage, 215, 265);
		textAlign(LEFT);
		text(APP_IMAGES_PER_PAGE, 260, 265);
		popStyle();

		// Bottom bar
		pushStyle();
		for (int i=height-30; i<height; i++) {
			stroke(50, 100+i*10);
			line(0,i , width, i);
		}
		popStyle();

		// Bottom bar title
		pushStyle();
		fill(255);
		textAlign(RIGHT);		
		textSize(10);
		text(APP_BOTTOM_TITLE, width-10, height-10);
		popStyle();
		
		// Record
		if (record) {
			record = false;

			if (null != images && images.length > 0) {

				float expWidth=2000;
				float expHeight = expWidth*1.4142f;

				// Calculate image height
				float hauteur = expHeight/prefImagesPerPage;

				// Calculate the total number of pages
				int totalNumberOfImages = (images.length*prefLoops) + 1; // +1 for cover page
				int totalPages =  ceil((float) totalNumberOfImages/prefImagesPerPage);

				// Images' dimensions
				float w = images[0].width;
				float h = images[0].height;
				float ratio = h/hauteur;

				int i = 0;

				int leftMargin = 100;

				for (int p=0; p < totalPages; p++) {

					PGraphics pg = createGraphics((int) expWidth, (int) expHeight, JAVA2D);
					pg.beginDraw();

					pg.pushMatrix();
					pg.background(255);

					for (int j=0; j < prefImagesPerPage && i < totalNumberOfImages ; j++) {

						pg.pushStyle();
						pg.fill(125);

						if (i < totalNumberOfImages-1) {
							pg.textSize(40);
							pg.text(i+1, leftMargin, hauteur/2);
						
							pg.image(images[i%images.length], expWidth-(w/ratio)-10, 10, w/ratio-20, h/ratio-20);
						}
						else {
							pg.pushStyle();
							pg.fill(125);
							pg.textSize(40);
							pg.text(APP_EXPORT_MADE1, leftMargin-20, 100);
							pg.textSize(100);
							pg.text(APP_EXPORT_MADE2, leftMargin, 250);
							pg.textSize(40);
							pg.text(APP_EXPORT_MADE3, leftMargin + 300, 250);
							
						}
						pg.popStyle();
						
						
						// Rectangle
						pg.pushStyle();
						pg.noFill();
						pg.stroke(125);
						pg.rect(0, 0, expWidth, hauteur);
						pg.popStyle();

						pg.translate(0, hauteur);

						i++;

					}

					pg.popMatrix();

					pg.endDraw();
					pg.save(output_folder+"/"+uid+"_"+p+".png");
				}
				infoMsg = String.format(MSG_EXPORT_DONE, ""+totalPages);
				images = null;

			}
		}
	}


	public void keyPressed() {
		if (key == ' ') {
			if (null == images || images.length == 0) {
				infoMsg = MSG_NOTHING_TO_EXPORT;
			}
			else {
				if (!record) {
					infoMsg = MSG_PLEASE_WAIT;
					uid = ""+System.currentTimeMillis();
					record = true;
				}
			}
		}
	}

	public void mouseClicked() {

		// Plus
		int x = 20;
		int y = 250;
		if (mouseY > y && mouseY < y+20) {
			// Minus
			if (mouseX > x && mouseX < x+20 ) {
				if (prefLoops > prefLoopsMin) {
					prefLoops--;
				}
			}
			// Plus
			else if (mouseX > x+50 && mouseX <x+70 ) {
				if (prefLoops < prefLoopsMax) {
					prefLoops++;
				}				
			}
		}

		// Nb per page
		x = 180;
		y = 250;
		if (mouseY > y && mouseY < y+20) {
			// Minus
			if (mouseX > x && mouseX <x+30 ) {
				if (prefImagesPerPage > prefImagesPerPageMin) {
					prefImagesPerPage--;
				}
			}
			// Plus
			else if (mouseX > x+50 && mouseX <x+70 ) {
				if (prefImagesPerPage < prefImagesPerPageMax) {
					prefImagesPerPage++;
				}				
			}
		}

	}

