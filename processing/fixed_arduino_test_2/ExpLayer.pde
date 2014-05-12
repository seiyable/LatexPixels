class ExpLayer {
  //=========== in-class variables ===========
  Pulse pl;
  Rise rs;
  Fall fl;
  
  //=========== constructor ===========
  ExpLayer() {
    pl = new Pulse();
    rs = new Rise();
    fl = new Fall();
  }

  //=========== express() ===========
  void express() {
      pl.pulseIt();
      rs.riseIt();
      fl.fallIt();

  }

  //=========== keyCommand() ===========
  void keyCommand(char _key, int _id) {
    //println(_key, _id);
    
    //-------- start pulse --------
    if (_key == 'a') {
      pl.addList(_id);
    }

    //-------- stop pulse --------
    if (_key == 'd') {
      pl.removeList(_id);
    }
    
    //-------- start rise --------
    if (_key == 'r') {
      rs.addList(_id);
    }

    //-------- stop rise --------
    if (_key == 't') {
      rs.removeList(_id);
    }

    //-------- start fall --------
    if (_key == 'f') {
      fl.addList(_id);
    }

    //-------- stop fall --------
    if (_key == 'g') {
      fl.removeList(_id);
    }
    
    
  }

  //=========== updateClock() ===========  
  void updateClock() {
      pl.updateClock();
      rs.updateClock();
      fl.updateClock();
    
  }
}

