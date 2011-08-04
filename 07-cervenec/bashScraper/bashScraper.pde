void setup(){

    String command = "ls";
    String dir = "/home/kof/";

    try{
        ProcessBuilder pb = new ProcessBuilder("/bin/bash", command);
        pb.directory(new File(dir));
        Process shell = pb.start();
        int exitVal = shell.waitFor();
        println(exitVal);


    }catch(Exception e){
    
    }
}
