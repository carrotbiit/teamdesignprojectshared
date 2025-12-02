class  Worker  {
  //fields
  PVector pos;  //position of the employee
  String  state;  //what they are currently doing (unloading incoming, loading outgoing, waiting, )
  
  //constructor
  Worker(PVector p)  {
    this.pos = p.copy();
    this.state = "Stationary";
    
  }
  
  
  //methods
  void  drawMe()  {
    
    noStroke();
    fill(0,255,0);
    circle(this.pos.x, this.pos.y, 8);
    
  }
  
  void  update()  {
    
    if  (this.state.equals("Stationary"))  {  //looking for work
    
      for  (Truck t : trucks)  {
        if  (t.state.equals("Stationary")  &&  t.numCurWorkers < 2)  {  //if this truck still needs workers, the 2 is arbitrary
        
          println("Worker ", Workers.indexOf(this), " has found truck", trucks.indexOf(t));
          
          this.state = "Working";  //set state
          t.numCurWorkers += 1;  //update how many workers are working on the trucks
          
          break;  //as to not pick multiple trucks
          
        }
      }
      
    }
    
    //else  //is working
  }
  
}
