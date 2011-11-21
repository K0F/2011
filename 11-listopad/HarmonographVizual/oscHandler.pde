
void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  
  if(theOscMessage.checkAddrPattern("/ctl")) {
    /* check if the typetag is the right one. */
    if(theOscMessage.checkTypetag("if")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      int sel = theOscMessage.get(0).intValue();  
      float v = theOscMessage.get(1).floatValue();
      //print("### received an osc message /test with typetag ifs.");
     
     val[sel] += (v-val[sel])/smoothing;
     
      return;
    }  
  } 
  //println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}
