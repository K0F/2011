import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Scanner;

public class FileHashTest {
    public static MessageDigest messageDigest;

    public static void main(String args[]) {
        Scanner scn = new Scanner(System.in);
        try {
            messageDigest = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        String line;
        while (true) {
            line = scn.next();
            System.out.println("  " + getSearchHash(line));
        }
    }

    static String getSearchHash(String query) {
        byte[] bs = messageDigest.digest(query.getBytes());
        byte bytes = bs[0];
        String s ="";
        try {
            for (int i = 1; i < bs.length; ++i) {
                System.out.print(bs[i]+"="+Integer.toHexString(bs[i] & 0xFF)+ " ");
                s += Integer.toHexString(bs[i] & 0xFF);
            }
            return s;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return "";
        }
    }
}
