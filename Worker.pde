class  Worker  {
  //fields
  PVector  pos;  //position of the worker
  PVector  vel;  //velocity of the worker
  PVector  target;  //where the worker is going
  String  state;  //what they are currently doing (Unloading, Loading, Storring, Retrieving, Waiting, )
  Package  holding;  //the package the worker is moving
  Package  targPack;  //the package the worker is SEARCHING FOR when retrieving
  int  targInd;  //the index of what we are targeting (shelf      )//, truck)
  Truck  targTruck;
  
  //constructor
  Worker(PVector p)  {
    this.pos = p.copy();
    this.vel = new PVector(0,0);
    this.target = p.copy();
    this.state = "Waiting";
    this.holding = null;
    this.targPack = null;
    this.targInd = 0;
    this.targTruck = null;
    
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
    
    totalWageExpense += simSpeed * wage / 20000;
    
    //general algo idea
    //if we are Waiting
      //check if the incoming truck needs to be unloaded and its num cur workers is low
        //if it needs workers work on it and set its target as such
        //else it doesnt need workers
          //check if the outgoing trucks need workers
            //if they do, they find the packages need and begin loading, or wait if there are none
            //if they dont, just wait
    //else
      //continue doing whatever you were doing (move)
    
    if  (this.state.equals("Waiting"))  {
      
      //Work on incoming
      //if  (  incomingTruck.state.equals("Unloading")  &&  incomingTruck.numCurWorkers < 5  &&  incomingTruck.packages.get(0).size() > 0  )  {
      if  (  incomingTruck.state.equals("Unloading")  &&  incomingTruck.numCurWorkers < 5  &&  incomingTruck.numCurWorkers < incomingTruck.packages.get(0).size()  )  {
        this.targetIncoming();
        this.setVelTarget();
        this.state = "Unloading";  //set state
        incomingTruck.numCurWorkers += 1;  //update how many workers are working on the trucks
        
      }
      
      //Work on outgoing
      else  {
        for  (Truck t: trucks)  {  //Loop through trucks
          if  (  t.state.equals("Stationary")  &&  t.numCurWorkers == 0)  {
            //println(t.position, frameCount);
            fill(255,0,0);
            circle(t.position.x, t.position.y, 5);
            for  (Shelf s: Shelves)  {  //Loop through shelves
              for  (  int i = 0 ; i < s.stored.size() ; i++  )  {  //Loop through packages
              
                fill(255,0,255);
                circle(s.pos.x  +  (i * 10), s.pos.y, 5);
                //println(s.stored.get(i).weight);
                //println(t.load);
                //println(t.canFit(  s.stored.get(i)  ));
                
                if  (  t.canFit(  s.stored.get(i)  )  &&  !s.claimed.get(i)  )  {  //Valid package, weight & not claimed
                  //println("valid PACKAGE", frameCount);
                  //this.targetOutgoing(t);
                  this.targPack = s.stored.get(i);
                  
                  this.targetShelf(s, i);
                  this.setVelTarget();
                  this.state = "Retrieving";  //set state
                  
                  this.targTruck = t;

                  //println(s.claimed.get(i));
                  
                  t.numCurWorkers += 1;  //update how many workers are working on the trucks
                  
                  break;  //Stop searching
                }
              }
              
              if  (  this.state.equals("Retrieving")  )  {
                break;  //Stop searching
              }
              
            }
          }
          
          if  (  this.state.equals("Retrieving")  )  {
                break;  //Stop searching
              }
          
        }
      }

    }  //end of waiting
    
    else  {//is working
      
      //red circle target TESTER
      if  (this.pos.x != this.target.x)  {
        fill(255,0,0);
        circle(this.target.x, this.target.y, 4);
      }
      
      
      
      //move closer to target if if the next frame we dont reach it
      if  (dist(this.pos.x, this.pos.y, this.target.x, this.target.y) > this.vel.copy().mult(simSpeed).mag())  {
        this.pos.add(this.vel.copy().mult(simSpeed));
      }
      
      else  {  //if we are close enough to target set our position to it
        this.pos = this.target.copy();
        
        //Unloading
        if  (  this.state.equals("Unloading")  )  {
          this.holding = incomingTruck.packages.get(0).get(0);
          incomingTruck.packages.get(0).remove(0);
          incomingTruck.numCurWorkers -= 1;
          this.state = "Storring";
          
          this.targetShelf();
          this.setVelTarget();
          
        }
        
        //Store in shelf
        else  if  (  this.state.equals("Storring")  )  {
          if  (  Shelves.get(targInd).stored.size()  <  5  )  {
            Shelves.get(targInd).stored.add(this.holding);
            Shelves.get(targInd).claimed.add(false);
            this.holding = null;
            this.state = "Waiting";
            
            //println(Shelves.get(targInd).stored.size());
          }
          else  {
            this.targetShelf();
            this.setVelTarget();
            //this.state = "Unloading";
          }
        }
        
        //Loading
        else  if  (  this.state.equals("Loading")  )  {
          targTruck.loadPackage(this.holding);
          this.holding = null;
          targTruck.numCurWorkers -= 1;
          this.state = "Waiting";
          
        }
        
        //Retrieving
        else  if  (  this.state.equals("Retrieving")  )  {
          this.holding = this.targPack;
          Shelves.get(targInd).claimed.remove(  Shelves.get(targInd).stored.indexOf(this.holding)  );
          Shelves.get(targInd).stored.remove(  this.holding  );
          
          this.state = "Loading";
          
          //was in loading
          targetOutgoing(targTruck);
          this.setVelTarget();
          
        }
        
      }
      
      
      
    }
  }
  
  //Sets target to closest outgoing Truck  (still needs work)
  void  targetOutgoing(Truck  t)  {
    this.target = t.restPosition.copy();
    this.target.y += 5;
    this.target.x -= 5;
  }
  
  //Sets target to incoming truck
  void  targetIncoming()  {
    this.target = incomingTruck.position.copy();
    this.target.y += 15;
    this.target.x += 10;
  }
  
  //Sets target to closest availible shelf, set targInd
  void  targetShelf()  {
    for  (Shelf s: Shelves)  {
      //Has room for package
      if  (s.stored.size() < 5)  {
        this.target = s.pos.copy();
        this.target.y -= sH;
        this.target.x += random(-sW/2, sW/2);
        this.targInd = Shelves.indexOf(s);
        
        break;
      }
    }
  }
  
  void  targetShelf(Shelf s,  int index)  {  //idk if this works
    this.target = s.pos.copy();
    this.target.y -= sH;
    this.target.x += random(-sW/2, sW/2);
    this.targInd = Shelves.indexOf(s);
    
    Shelves.get( Shelves.indexOf(s) ).claimed.set(index, true);
    
    //println("\t", s.claimed);
    
  }
  
  //Calculates the velocity that the worker should be moving to reach its destination
  void  setVelTarget()  {
    this.vel = PVector.sub(this.target, this.pos);
    this.vel.normalize();
    this.vel.mult(workerSpeed);
  }
  
}
