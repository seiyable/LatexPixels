class ExpManager {
  //=========== in-class variables ===========
  ArrayList<ExpLayer> eLayers = new ArrayList<ExpLayer>();


  //=========== constructor ===========
  ExpManager() {
    eLayers.add(new ExpLayer());
  }

  //=========== process() ===========  
  void process() {
        
    for (ExpLayer el : eLayers) {
      el.express();
    }
  
    for (ExpLayer el : eLayers) {
      el.updateClock();
    }
  }
  
  //=========== keyHandler() ===========
  void keyHandler(char _key, int _id) {
    // this instruction should be sent to only selected expression
    for (ExpLayer el : eLayers) {
      el.keyCommand(_key, _id);
    }
  }
}
