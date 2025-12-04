class  Shelf  {
  //fields
  PVector pos;  //position of the shelves, the centre of the drawn rectangle
  ArrayList<Package> stored;  //list of stored package objects, String is a place holder
  
  //constructor
  Shelf(PVector p)  {
    this.pos = p.copy();
    this.stored = new ArrayList();
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
    textSize(14);
    text(Shelves.indexOf(this) , this.pos.x, this.pos.y + (sH/2));
    textSize(20);
    text(this.stored.size() , this.pos.x + 50, this.pos.y + (sH/2));
  }
  
  //void  addPackage()  {
  
  //}
  //void  removePackage()  {
  
  //}
  
}
