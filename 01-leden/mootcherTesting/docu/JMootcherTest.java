

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.SimpleTimeZone;
import sun.audio.*; //import the sun.audio package
import java.io.*;

import javax.sound.sampled.*;

import cami.jmootcher.*;

public class JMootcherTest {

    public static void main(String args[]) {

        try {
            JMootcher mootcher = JMootcher.factory("", "");
            AudioSample f = mootcher.getSampleByID(4060);
            System.out.println(f.getOriginalFileName());
            BufferedReader br = new BufferedReader(new InputStreamReader(f
                    .getPreviewInputStream()));
            System.out.println(br.readLine());
            // System.out.println(mootcher.getXMLForSearch("tag", 0, 0, 0, 0,
            // 0));

            /** 44100Hz, 16-bit, stereo, signed, little-endian */
            AudioFormat playbackFormat = new AudioFormat(44100, 16, 2, true,
                    false);

            AudioInputStream stream = AudioSystem.getAudioInputStream(f
                    .getPreviewInputStream());
            // source = AudioSystem.getAudioInputStream(playbackFormat, source);

//            DataLine.Info info = new DataLine.Info(Clip.class, stream
//                    .getFormat(), ((int) stream.getFrameLength() * format
//                    .getFrameSize()));

            Clip clip = (Clip) AudioSystem.getClip();
//            clip.addLineListener(this);
            clip.open(stream);
            clip.start();

            // System.out.println(mootcher.getSimilar(4030));
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
