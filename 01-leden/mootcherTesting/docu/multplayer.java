import java.util.Scanner;

import javazoom.jlgui.basicplayer.BasicPlayer;
import javazoom.jlgui.basicplayer.BasicPlayerException;
import cami.FileSizeChecker;
import cami.jmootcher.AudioSample;
import cami.jmootcher.JMootcher;

public class multplayer extends SimpleJMootcherTest {
    
    public static void main(String args[]) {
        multplayer mt = new multplayer();
    }
    
    public void runTest() {
        // fetch username and password
        String pswd, user;
        JMootcher mootcher = null;
        boolean succeded_login = false;
        while (!succeded_login) {
            System.out.print("Type your Username: ");
            user = scanner_.next();

            if (user.length() > 2) {
                System.out.print("Type your password: ");
                pswd = scanner_.next();

                if (pswd.length() > 2) {
                    try {
                        mootcher = JMootcher.factory(user, pswd);
                        succeded_login = true;
                        System.out.println("//// succeded to login ////");
                    } catch (Exception e) {
                        System.out
                                .println("Provided username / password-combination wasn't correct!");
                        succeded_login = false;
                    }
                } else {
                    System.out.println("   password \"" + pswd
                            + "\" too short! ");
                }
            } else {
                System.out.println("   username too short!");
            }
        }

        int start = 100;
        int length = 30;
        AudioSample sample[] = new AudioSample[length];
        // preload all samples
        try {
            for (int i = start; i < start+length; ++i) {
                // create a new AudioSample-Object
                sample[i-start] = mootcher.getSampleByID(i);
                if (sample[i-start] != null) {
                    // since we're laoding the stuff rfom the internet there
                    // shold be a little buffer, so we use the
                    // FileSizeChecker-Class
                    // to wait until the file has reached 15kb
                }
            }
            Thread.sleep(10);
            for (int i = 0; i < sample.length; ++i) {
                if (sample[i] == null)
                    continue;
                // player.open(new FileInputStream(sample.getSample()));
                BasicPlayer player = new BasicPlayer();
                player.open(sample[i].getPreview());
                player.play();
                player.setGain(0.2);
                player.setPan(0.0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        //logout and shutdown programm
        exit();

    }
}
