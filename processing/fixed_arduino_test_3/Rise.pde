class Rise {
  //=========== in-class variables ===========
  ArrayList<Integer> riseIDs;
  float servoMax = 179;
  ArrayList<Float> clocks;
  ArrayList<Float> clockSpeeds;
  ArrayList<Integer> lifespans;

  //=========== constructor ===========
  Rise() {
    riseIDs = new ArrayList<Integer>();
    clocks = new ArrayList<Float>();
    clockSpeeds = new ArrayList<Float>();
    lifespans = new ArrayList<Integer>();
  }

  //=========== riseIt() ===========  
  void riseIt() {

    for (Module m : modules) {
      if (riseIDs.contains(m.id)) {
        int riseIndex = riseIDs.indexOf(m.id);
        int counter = (int) floor(clocks.get(riseIndex) / 360);
        
        if(counter >= lifespans.get(riseIndex)){
          //println(counter);
          //println(lifespans.get(riseIndex));
          removeList(m.id);
        } else {
          m.servoAngle = 0;
        }
      }
    }
  }

  //=========== addList() ===========
  void addList(int _id) {
    riseIDs.add(_id);
    clocks.add(0.0);
    clockSpeeds.add(5.0);
    lifespans.add(3);

    for (Integer rids : riseIDs) {
      //print(rids + " ");
    }
    //println();
  }

  //=========== removeList() ===========
  void removeList(int _id) { 
    if (riseIDs.size() > 0) {
      if (riseIDs.contains(_id)) {
        int removeIndex = riseIDs.indexOf(_id);
        riseIDs.remove(removeIndex);
        clocks.remove(removeIndex);
        clockSpeeds.remove(removeIndex);
        lifespans.remove(removeIndex);

        for (Module m : modules) {
          if (m.id == _id) {
            m.servoAngle = 120;
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

