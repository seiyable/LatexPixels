/*
class Chain {
  //=========== in-class variables ===========
  ArrayList<Integer> chainIDs;
  float servoMax = 180;
  ArrayList<Float> clocks;
  ArrayList<Float> clockSpeeds;
  ArrayList<Integer> lifespans;

  //=========== constructor ===========
  Chain() {
    chainIDs = new ArrayList<Integer>();
    clocks = new ArrayList<Float>();
    clockSpeeds = new ArrayList<Float>();
    lifespans = new ArrayList<Integer>();
  }

  //=========== chainIt() ===========  
  void chainIt() {

    for (Module m : modules) {
      if (chainIDs.contains(m.id)) {
        int blinkIndex = blinkIDs.indexOf(m.id);
        int counter = (int) floor(clocks.get(blinkIndex) / 360);
        
        if(counter >= lifespans.get(blinkIndex)){
          //println(counter);
          //println(lifespans.get(blinkIndex));
          removeList(m.id);
        } else {
          float theta = radians(clocks.get(blinkIndex) % 360);
          m.servoAngle = (1 +sin(theta - PI))*servoMax/2; // 0 ~ servoMax
        }
      }
    }
  }

  //=========== addList() ===========
  void addList(int _id) {
    blinkIDs.add(_id);
    clocks.add(0.0);
    clockSpeeds.add(5.0);
    lifespans.add(3);

    for (Integer bids : blinkIDs) {
      print(bids + " ");
    }
    println();
  }

  //=========== removeList() ===========
  void removeList(int _id) { 
    if (blinkIDs.size() > 0) {
      if (blinkIDs.contains(_id)) {
        int removeIndex = blinkIDs.indexOf(_id);
        blinkIDs.remove(removeIndex);
        clocks.remove(removeIndex);
        clockSpeeds.remove(removeIndex);
        lifespans.remove(removeIndex);

        for (Module m : modules) {
          if (m.id == _id) {
            m.servoAngle = 0;
          }
        }
      }
    }
  }
  //=========== updateClock() ===========  
  void updateClock() {
    for (int i = 0; i < clocks.size(); i++) {
      float clock = clocks.get(i);
      float clockSpeed = clockSpeeds.get(i);
      clock += clockSpeed;

      clocks.set(i, clock);
    }
  }
}
*/
