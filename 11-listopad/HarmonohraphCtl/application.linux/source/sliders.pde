
void controlEvent(ControlEvent theEvent) {
  
   if(theEvent.isController()) { 
     
     
     for(int i =0  ;i<names.length;i++){
       if(theEvent.controller().name()==names[i]) {
         val[i] = theEvent.controller().value();
         send(i);
       }
     
     }
     
     
   }
  
}


