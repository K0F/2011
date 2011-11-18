void setup(){
	size(320,240);
	ping("lab19.ath.cx");

}

void ping(String _ip){
		String ip = _ip+"";
		String pingResult = "";

		String pingCmd = "ping " + ip;

		try {
			Runtime r = Runtime.getRuntime();
			Process p = r.exec(pingCmd);

			BufferedReader in = new BufferedReader(new
					InputStreamReader(p.getInputStream()));
			String inputLine;
			while ((inputLine = in.readLine()) != null) {
				System.out.println(inputLine);
				pingResult += inputLine;
			}
			in.close();
		}//try
		catch (IOException e) {
			System.out.println(e);
		}
}
