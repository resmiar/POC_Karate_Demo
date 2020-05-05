var encrypt =function(arg) {
    var TrippleDes = Java.type('packageOne.TrippleDes');
    var jd = new TrippleDes();
    return jd.encrypt(arg);  
  }
  var decrypt =function(arg) {
    var TrippleDes = Java.type('packageOne.TrippleDes');
    var jd = new TrippleDes();
    return jd.decrypt(arg);  
  }