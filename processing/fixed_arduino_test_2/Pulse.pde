class Pulse {
  //=========== in-class variables ===========
  ArrayList<Integer> pulseIDs;
  float servoMax = 179;
  ArrayList<Float> clocks;
  ArrayList<Float> clockSpeeds;
  ArrayList<Integer> lifespans;

  //=========== constructor ===========
  Pulse() {
    pulseIDs = new ArrayList<Integer>();
    clocks = new ArrayList<Float>();
    clockSpeeds = new ArrayList<Float>();
    lifespans = new ArrayList<Integer>();
  }

  //=========== pulseIt() ===========  
  void pulseIt() {

    for (Module m : modules) {
      if (pulseIDs.contains(m.id)) {
        int pulseIndex = pulseIDs.indexOf(m.id);
        int counter = (int) floor(clocks.get(pulseIndex) / 360);
        
        if(counter >= lifespans.get(pulseIndex)){
          //println(counter);
          //println(lifespans.get(pulseIndex));
          removeList(m.id);
        } else {
          float theta = radians(clocks.get(pulseIndex) % 360);
          m.servoAngle = (1 +sin(theta - PI))*servoMax/2; // 0 ~ servoMax
        }
      }
    }
  }

  //=========== addList() ===========
  void addList(int _id) {
    pulseIDs.add(_id);
    clocks.add(0.0);
    clockSpeeds.add(5.0);
    lifespans.add(3);

    for (Integer pids : pulseIDs) {
      //print(pids + " ");
    }
    //println();
  }

  //=========== removeList() ===========
  void removeList(int _id) { 
    if (pulseIDs.size() > 0) {
      if (pulseIDs.contains(_id)) {
        int removeIndex = pulseIDs.indexOf(_id);
        pulseIDs.remove(removeIndex);
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

