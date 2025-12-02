class  Shelf  {
  //fields
  PVector pos;  //position of the shelves, the centre of the drawn rectangle
  ArrayList<String> stored;  //list of stored package objects, String is a place holder
  
  //constructor
  Shelf(PVector p)  {
    this.pos = p.copy();
  }
  
  //methods
  void  drawMe()  {
    //strokeWeight(2);
    //stroke(100);
    rectMode(CENTER);
    //fill(130);
    fill(0,0,255);
    rect(pos.x, pos.y, sW, sH);
    
    fill(255);
    textAlign(CENTER);
    textSize(20);
    text(Shelves.indexOf(this) ,pos.x, pos.y + (sH/2));
  }
  
  //void  addPackage()  {
  
  //}
  //void  removePackage()  {
  
  //}
  
}
