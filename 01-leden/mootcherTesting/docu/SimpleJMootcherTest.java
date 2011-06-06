import java.util.Scanner;

import javazoom.jlgui.basicplayer.BasicPlayer;

import cami.jmootcher.JMootcher;


public abstract class SimpleJMootcherTest {

    protected JMootcher mootcher_;
    protected BasicPlayer player_;
    protected Scanner scanner_;

    public SimpleJMootcherTest() {
        mootcher_ = null;
        scanner_ = new Scanner(System.in);
        player_ = new BasicPlayer();
        login();
        runTest();
    }
    
    public abstract void runTest();
    
    public void login() {
        // fetch username and password
        String pswd, user;
        boolean succeded_login = false;
        while (!succeded_login) {
            System.out.print("Type your Username: ");
            user = scanner_.next();
    
            if (user.length() > 2) {
                System.out.print("Type your password: ");
                pswd = scanner_.next();
    
                if (pswd.length() > 2) {
                    try {
                        mootcher_ = JMootcher.factory(user, pswd);
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
    }

    public void exit() {
        mootcher_.logout();
        System.exit(0);
    }

}
