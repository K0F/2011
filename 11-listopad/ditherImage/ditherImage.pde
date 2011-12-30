void setup(){

RGBTriple[][] image = new RGBTriple[145][100];

    InputStream raw_in = new BufferedInputStream(new FileInputStream(args[0]));
    for (int y = 0; y < image.length; y++) {
        for (int x = 0; x < image[0].length; x++) {
            image[y][x] = new RGBTriple();
            raw_in.read(image[y][x].channels, 0, 3);
        }
    }
    raw_in.close();

    RGBTriple[] palette = {
        new RGBTriple(149, 91, 110),
        new RGBTriple(176, 116, 137),
        new RGBTriple(17, 11, 15),
        new RGBTriple(63, 47, 69),
        new RGBTriple(93, 75, 112),
        new RGBTriple(47, 62, 24),
        new RGBTriple(76, 90, 55),
        new RGBTriple(190, 212, 115),
        new RGBTriple(160, 176, 87),
        new RGBTriple(116, 120, 87),
        new RGBTriple(245, 246, 225),
        new RGBTriple(148, 146, 130),
        new RGBTriple(200, 195, 180),
        new RGBTriple(36, 32, 27),
        new RGBTriple(87, 54, 45),
        new RGBTriple(121, 72, 72)
    };

    byte[][] result = floydSteinbergDither(image, palette);
/*
    OutputStream raw_out = new BufferedOutputStream(new FileOutputStream(args[1]));
    for (int y = 0; y < result.length; y++) {
        for (int x = 0; x < result[y].length; x++) {
            raw_out.write(palette[result[y][x]].channels, 0, 3);
        }
    }
    raw_out.close();
*/
}

class RGBTriple {
    public final byte[] channels;
    public RGBTriple() { channels = new byte[3]; }
    public RGBTriple(int R, int G, int B)
    { channels = new byte[]{(byte)R, (byte)G, (byte)B}; }
}
