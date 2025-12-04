class  Worker  {
  //fields
  PVector  pos;  //position of the worker
  PVector  vel;  //velocity of the worker
  PVector  target;  //where the worker is going
  String  state;  //what they are currently doing (Unloading, Loading, Storring, Retrieving, Waiting, )
  Package  holding;  //the package the worker is moving
  
  //constructor
  Worker(PVector p)  {
    this.pos = p.copy();
    this.vel = new PVector(0,0);
    this.target = p.copy();
    this.state = "Waiting";
    this.holding = null;
    
  }
  
  
  //methods
  void  drawMe()  {
    
    noStroke();
    fill(0,255,0);
    circle(this.pos.x, this.pos.y, 8);
    
    //if  (this.holding != null)  {
    //  fill(holding.colour);
    //  square(this.pos.x, this.pos.y + 4, 4);
    //}
    
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
    
    if  (this.state.equals("Waiting")  &&  incomingTruck.state.equals("Unloading"))  {
      this.targetIncoming();
      this.setVelTarget();
      this.state = "Working";  //set state

    }
    
    //if  (this.state.equals("Waiting"))  {  //looking for work
      
    //  this.vel = new PVector(0,0);
      
    //  for  (Truck t : trucks)  {
    //    if  (t.state.equals("Stationary")  &&  t.numCurWorkers < 2)  {  //if this truck still needs workers, the 2 is arbitrary
        
    //      //println("Worker ", Workers.indexOf(this), " has found truck", trucks.indexOf(t));
          
    //      this.state = "Working";  //set state
    //      t.numCurWorkers += 1;  //update how many workers are working on the trucks
         
    //      this.target = t.restPosition.copy();
    //      this.target.y += 5;
    //      this.target.x -= 5;
          
    //      this.vel = PVector.sub(this.target, this.pos);
    //      this.vel.normalize();
    //      this.vel.mult(workerSpeed);
          
    //      break;  //as to not pick multiple trucks
          
    //    }
    //  }
      
    //}
    
    else  {//is working
      //this.target = new PVector(mouseX, mouseY);
      //this.vel = PVector.sub(this.target, this.pos);
      //this.vel.normalize();
      
      //println("moving?");
      circle(this.target.x, this.target.y, 10);
      
      //move closer to target if if the next frame we dont reach it
      if  (dist(this.pos.x, this.pos.y, this.target.x, this.target.y) > this.vel.copy().mult(simSpeed).mag())  {
        this.pos.add(this.vel.copy().mult(simSpeed));
      }
      else  {  //if we are close enough to target set our position to it
        this.pos = this.target.copy();
      }
      
    }
  }
  
  void  targetOutgoing(Truck  t)  {
    this.target = t.restPosition.copy();
    this.target.y += 5;
    this.target.x -= 5;
  }
  
  void  targetIncoming()  {
    this.target = incomingTruck.position.copy();
    this.target.y += 15;
    this.target.x += 10;
  }
  
  void  setVelTarget()  {
    this.vel = PVector.sub(this.target, this.pos);
    this.vel.normalize();
    this.vel.mult(workerSpeed);
  }
  
}
