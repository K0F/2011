import java.util.Scanner;

import javazoom.jlgui.basicplayer.BasicPlayer;
import javazoom.jlgui.basicplayer.BasicPlayerException;

import cami.FileSizeChecker;
import cami.jmootcher.AudioSample;

public class SimpleCommandLineTest extends SimpleJMootcherTest {

    public static void main(String args[]) {
        SimpleCommandLineTest test = new SimpleCommandLineTest();
    }

    public void runTest() {
        BasicPlayer player = new BasicPlayer();

        System.out
                .println("since this is a short and simple demo,"
                        + " it's possible, that a sample-preview isn't loaded completely."
                        + " If so just retype the ID to play it again, it should work then.");

        // ask for an ID then play it and show some infos
        boolean run = true;
        String next;
        int ID;
        AudioSample sample;

        while (run) {
            System.out.print("Type an ID for a search, stop or exit: ");
            next = scanner_.next();

            if (next.equals("exit")) {
                exit();
            } else if (next.equals("stop")) {
                try {
                    player.stop();
                } catch (BasicPlayerException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }

            try {
                ID = Integer.parseInt(next);
                // create a new AudioSample-Object
                sample = mootcher_.getSampleByID(ID);
                System.out.println("    name=" + sample.getOriginalFileName()
                        + " dur=" + sample.getDuration() + "s, type="
                        + sample.getExtension());
                if (sample == null) {
                    System.out.println("   sample with ID=" + ID
                            + " didn't exist!");
                } else {
                    // since we're laoding the stuff rfom the internet there
                    // shold be a little buffer, so we use the
                    // FileSizeChecker-Class
                    // to wait until the file has reached 15kb
                    new FileSizeChecker(sample.getPreview(), 15 * 1024);
                    System.out.println("   playing preview"
                            + sample.getPreview().getAbsolutePath() + " size:"
                            + sample.getFileSize() / 1024 + "kb"
                            + " prev-size:" + sample.getPreview().length()
                            / 1024 + "kb");

                    // TODO Why's this break needed for getting a File?
                    // is it possible to write and read to the same file? it
                    // should!
                    Thread.sleep(200);
                    // player.open(new FileInputStream(sample.getSample()));
                    player.open(sample.getPreview());
                    player.play();
                    player.setGain(1.0);
                    player.setPan(0.0);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
