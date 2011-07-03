/**
DataBuffer taken from http://wiki.processing.org/w/Asynchronous_data/image_loading
@author toxi
*/
 
import java.io.*;
import javax.imageio.*;
import java.awt.image.BufferedImage;
 
import processing.core.PImage;
 
public class DataBuffer {
 
  private byte[] bytes;
 
  public DataBuffer(byte[] buf) {
    bytes=buf;
  }
 
  public byte[] getRaw() {
     return bytes;
  }
 
  public String getAsText() {
    return getAsText("UTF-8");
  }
 
  public String getAsText(String encoding) {
    try {
      return new String(bytes,encoding);
    } 
    catch(Exception e) {
      e.printStackTrace();
    }
    return null;
  }
 
  // updated according to:
  // http://forum.processing.org/topic/converting-bufferedimage-to-pimage#25080000000340208
  public PImage getAsImage() {
    try {
      ByteArrayInputStream bis=new ByteArrayInputStream(bytes); 
      BufferedImage bimg = ImageIO.read(bis); 
      PImage img=new PImage(bimg.getWidth(),bimg.getHeight(),PConstants.ARGB);
      bimg.getRGB(0, 0, img.width, img.height, img.pixels, 0, img.width);
      img.updatePixels();
      return img;
    }
    catch(Exception e) {
      System.err.println("Can't create image from buffer");
      e.printStackTrace();
    }
    return null;
  }
}
