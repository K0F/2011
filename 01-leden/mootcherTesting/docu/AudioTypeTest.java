import java.io.File;

import javazoom.jlgui.basicplayer.*;

/**
 * tries to play different types of audio
 * <ol>
 * <li>mp3</li>
 * <li>aiff</li>
 * <li>wav</li>
 * <li>au</li>
 * <li>flac</li>
 * <li>ogg</li>
 * </ol>
 * 
 * Needs the following files placed into the classpath
 * <ol>
 *      <li>mp3spi</li>
 *      <li>jl</li>
 *      <li>trintonus_share</li>
 *      <li>vorbisspi</li>
 *      <li>jflac</li>
 * </ol>
 * 
 * @author cami
 * 
 */
public class AudioTypeTest {
    
    static String pathToTestSounds= "/Users/cami/Documents/workspace/jMootcher/Tests/Sounds/";
    
    public static void main(String args[]) {
        BasicPlayer player = new BasicPlayer();

        // mp3
        try {
            System.out.println("start loading mp3");
            player.open(new File(pathToTestSounds+"tone.mp3"));
            player.play();
            System.out.println("playing mp3");
            Thread.sleep(1000);
        } catch (Exception e) {
            System.out.println(">>> failed loading mp3");
            e.printStackTrace();
        }

        // aiff
        try {
            System.out.println("start loading aiff");
            player.open(new File(pathToTestSounds+"tone.aiff"));
            player.play();
            System.out.println("playing aiff");
            Thread.sleep(1000);
        } catch (Exception e) {
            System.out.println(">>> failed loading aiff");
            e.printStackTrace();
        }
        
        // wav Troubles with some PCM-coded blablabla!
        try {
            System.out.println("start loading wav");
            player.open(new File(pathToTestSounds+"tone.wav"));
            player.play();
            System.out.println("playing wav");
            Thread.sleep(1000);
        } catch (Exception e) {
            System.out.println(">>> failed loading wav");
            e.printStackTrace();
        }
        
        // au
        try {
            System.out.println("start loading au");
            player.open(new File(pathToTestSounds+"tone.au"));
            player.play();
            System.out.println("playing au");
            Thread.sleep(1000);
        } catch (Exception e) {
            System.out.println(">>> failed loading au");
            e.printStackTrace();
        }
        
        // flac -TROUBLES!!!
        try {
            System.out.println("start loading flac");
            player.open(new File(pathToTestSounds+"tone.flac"));
            player.play();
            System.out.println("playing flac");
            Thread.sleep(1000);
        } catch (Exception e) {
            System.out.println(">>> failed loading flac");
            e.printStackTrace();
        }
        
        // ogg - TROUBLES!!!
        try {
            System.out.println("start loading ogg");
            player.open(new File(pathToTestSounds+"tone.ogg"));
            player.play();
            System.out.println("playing ogg");
            Thread.sleep(1000);
        } catch (Exception e) {
            System.out.println(">>> failed loading ogg");
            e.printStackTrace();
        }
        

        try {
            System.out.println("start loading ogg");
            player.open(new File(pathToTestSounds+"startup2.ogg"));
            player.play();
            System.out.println("playing ogg");
            Thread.sleep(1000);
        } catch (Exception e) {
            System.out.println(">>> failed loading ogg");
            e.printStackTrace();
        }
    }
}
