class Fall {
  //=========== in-class variables ===========
  ArrayList<Integer> fallIDs;
  float servoMax = 179;
  ArrayList<Float> clocks;
  ArrayList<Float> clockSpeeds;
  ArrayList<Integer> lifespans;

  //=========== constructor ===========
  Fall() {
    fallIDs = new ArrayList<Integer>();
    clocks = new ArrayList<Float>();
    clockSpeeds = new ArrayList<Float>();
    lifespans = new ArrayList<Integer>();
  }

  //=========== fallIt() ===========  
  void fallIt() {

    for (Module m : modules) {
      if (fallIDs.contains(m.id)) {
        int fallIndex = fallIDs.indexOf(m.id);
        int counter = (int) floor(clocks.get(fallIndex) / 360);
        
        if(counter >= lifespans.get(fallIndex)){
          //println(counter);
          //println(lifespans.get(fallIndex));
          removeList(m.id);
        } else {
          m.servoAngle = servoMax;
        }
      }
    }
  }

  //=========== addList() ===========
  void addList(int _id) {
    fallIDs.add(_id);
    clocks.add(0.0);
    clockSpeeds.add(5.0);
    lifespans.add(3);

    for (Integer fids : fallIDs) {
      //print(fids + " ");
    }
    //println();
  }

  //=========== removeList() ===========
  void removeList(int _id) { 
    if (fallIDs.size() > 0) {
      if (fallIDs.contains(_id)) {
        int removeIndex = fallIDs.indexOf(_id);
        fallIDs.remove(removeIndex);
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

