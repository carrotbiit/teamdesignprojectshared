class  Worker  {
  //fields
  PVector  pos;  //position of the worker
  PVector  vel;  //velocity of the worker
  PVector  target;  //where the worker is going
  String  state;  //what they are currently doing (Unloading, Loading, Storring, Retrieving, Waiting, )
  
  //constructor
  Worker(PVector p)  {
    this.pos = p.copy();
    this.vel = new PVector(0,0);
    this.target = p.copy();
    this.state = "Waiting";
    
  }
  
  
  //methods
  void  drawMe()  {
    
    noStroke();
    fill(0,255,0);
    circle(this.pos.x, this.pos.y, 8);
    
  }
  
  void  update()  {
    //if we are Waiting
      //check if the incoming truck needs to be unloaded and its num cur workers is low
        //if it needs workers work on it and set its target as such
        //else it doesnt need workers
          //check if the outgoing trucks need workers
            //if they do, they find the packages need and begin loading, or wait if there are none
            //if they dont, just wait
    //else
      //continue doing whatever you were doing (move)
    
    if  (this.state.equals("Waiting"))  {  //looking for work
      
      this.vel = new PVector(0,0);
      
      for  (Truck t : trucks)  {
        if  (t.state.equals("Stationary")  &&  t.numCurWorkers < 2)  {  //if this truck still needs workers, the 2 is arbitrary
        
          //println("Worker ", Workers.indexOf(this), " has found truck", trucks.indexOf(t));
          
          this.state = "Working";  //set state
          t.numCurWorkers += 1;  //update how many workers are working on the trucks
         
          this.target = t.restPosition.copy();
          this.target.y += 5;
          
          this.vel = PVector.sub(this.target, this.pos);
          this.vel.normalize();
          this.vel.mult(0.085);
          
          break;  //as to not pick multiple trucks
          
        }
      }
      
    }
    
    else  {//is working
      //this.target = new PVector(mouseX, mouseY);
      //this.vel = PVector.sub(this.target, this.pos);
      //this.vel.normalize();
      
      //move to target if we havent reached it yet
      if  (dist(this.pos.x, this.pos.y, this.target.x, this.target.y) > 5)  {
        this.pos.add(this.vel.copy().mult(simSpeed));
      }
      
    }
  }
  
}
