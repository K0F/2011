import javazoom.jlgui.basicplayer.BasicPlayerException;
import cami.jmootcher.AudioSample;

/**
 * lets do some searchings...
 * 
 * @author cami
 * 
 */
public class SearchTest extends SimpleJMootcherTest {

    public static void main(String args[]) {
        SearchTest test = new SearchTest();
    }

    private String helpText_ = "Type a word for keword-search";

    @Override
    public void runTest() {
        System.out.println(helpText_);
        String line = scanner_.nextLine().trim();;

        AudioSample singleSample;
        AudioSample[] samples;
        
        while (true) {
            System.out.print(">>");
            line = scanner_.nextLine().trim();
            if (line.length() == 0) {
                continue;
            }

            if (line.equals("exit")) {
                exit();
            } else if (line.startsWith("-s")) {
                int ID = Integer.parseInt(line.substring(3));
                printSearchResults(mootcher_.getSimilarSamples(ID));
            } else if (line.startsWith("-ds")) {
                int ID = Integer.parseInt(line.substring(4));
                printSearchResults(mootcher_.getDissimilarSamples(ID));
            } else if (line.startsWith("-p") || line.startsWith("-play")) {
                int ID = Integer
                        .parseInt(line.substring(line.indexOf(" ") + 1));
                AudioSample sample = mootcher_.getSamplesByID(ID);
                try {
                    player_.open(sample.getPreview());
                    player_.play();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if (line.startsWith("-h") || line.startsWith("-help")) {
                System.out.println(helpText_);            
            } else {
                printSearchResults(mootcher_.getSamples(line));
            }

        }

    }

    protected void printSearchResults(AudioSample[] samples) {

        System.out.println("   found " + samples.length + " samples:");
        for (int i = 0; i < samples.length; ++i) {
            System.out.println("    " + i + ". " + samples[i]);
        }
    }

}
