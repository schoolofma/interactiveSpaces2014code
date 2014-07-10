// with arrays
//Ele[] myEle;

// with ArrayList
ArrayList<Ele> myEle;

void setup() {
  // with arrays, fixed size:
  //myEle = new Ele[10];
  
  // with ArrayList
  // Note we did not specify a size
  myEle = new ArrayList<Ele>();
  
  // Set item in array:
  // myEle[3] = new Ele("blaa");
  
  // Add items in ArrayList
  myEle.add(new Ele("oeuc"));
  myEle.add(new Ele("aace"));
  myEle.add(new Ele("ccch"));
  
  // With ArrayList you can remove items:
  myEle.remove(1);
  
  // size of arrays: 
  // myEle.length
  
  // size of ArrayList:
  println(myEle.size());  
}
