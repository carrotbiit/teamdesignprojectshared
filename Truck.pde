class Truck {
  // Fields
  ArrayList<ArrayList<Package>> packages; // Packages are grouped by streets
  Road roadOn;
  PVector position, velocity;
  PVector restPosition;
  String state; // "Stationary", "Leaving Warehouse", "Going to Street", "At Street", "Leaving Street", "Returning from Street", "Returning from Intersection"
  float load;
  float maxCapacity;
  int streetIdx; // Current street of the struck
  int  numCurWorkers;  //the number of workers working on a truck

  // Constructor method
  Truck(Road roadOn, float x, float y) {
    this.packages = new ArrayList<ArrayList<Package>>();
    this.roadOn = roadOn;
    this.position = new PVector(x, y);
    this.velocity = new PVector(dT * simSpeed, 0);
    this.restPosition = this.position.copy();
    this.state = "Stationary";
    this.load = 0;
    for (int idx = 0; idx < streetCount; idx++) {
      packages.add(new ArrayList<Package>());
    }
    streetIdx = -1;
  }

  // Method to get the current load
  float getLoad() {
    return this.load;
  }
  
  // Method to check if another package can fit
  boolean canFit(Package item) {
    return this.load + item.weight <= maxCapacity;
  }

  // Method to leave the warehouse
  void leaveWarehouse() {
    this.roadOn = warehouseOut;
    this.state = "Leaving Warehouse";
    this.position = new PVector(this.roadOn.center.x - this.roadOn.radiusWidth, this.roadOn.center.y);
  }
  
  
  // Method to move to the next houses
  void move() {
    // Warehouse is not supposed to move
    if (this.state.equals("Stationary")) {
      return;
    }
    this.position.add(this.velocity);
    // Truck has left the warehouse
    if (this.state.equals("Leaving Warehouse") && isNear(this.position.x, this.roadOn.center.x + this.roadOn.radiusWidth)) {
      this.state = "Going to Street";
      this.streetIdx = locateNextStreet();
      this.roadOn = streets.get(streetIdx);
      if (this.position.y < this.roadOn.center.y) {
        this.position = new PVector(mergeRoad.center.x - mergeRoad.radiusWidth, mergeRoad.center.y - warehouseOut.radiusHeight);
        this.velocity = new PVector(0, dT * simSpeed);
      } else {
        this.velocity = new PVector(0, -dT * simSpeed);
        this.position = new PVector(mergeRoad.center.x, mergeRoad.center.y + warehouseOut.radiusHeight);
      }
    }
    // Truck is at its designated street
    else if (this.state.equals("Going to Street") && isNear(this.position.y, this.roadOn.center.y)) {
      this.state = "At Street";
      this.velocity = new PVector(dT * simSpeed, 0);
    } 
    // Truck finished delivering packages at its street
    else if (this.state.equals("At Street") && this.packages.get(this.streetIdx).isEmpty()) {
      this.state = "Leaving Street";
      this.position = new PVector(this.position.x, this.roadOn.center.y - this.roadOn.radiusHeight);
      this.velocity = new PVector(-dT * simSpeed, 0);
    } 
    // Truck has left its street
    else if (this.state.equals("Leaving Street") && isNear(this.position.x, mergeRoad.center.x)) {
      this.streetIdx = locateNextStreet();
      if (this.streetIdx == -1) {
        this.state = "Returning from Street";
        this.roadOn = warehouseOut;
        this.velocity = new PVector(0, -dT * simSpeed);
      }
      else {
        this.state = "Going to Street";
        this.roadOn = streets.get(streetIdx);
        this.velocity = new PVector(0, dT * simSpeed);
      }
      this.position = new PVector(mergeRoad.center.x - mergeRoad.radiusWidth, this.position.y);
    }
    // Truck has returned to the warehouse street
    else if (this.state.equals("Returning from Street") && isNear(this.position.y, this.roadOn.center.y)) {
      this.state = "Returning from Intersection";
      this.velocity = new PVector(-dT * simSpeed, 0);
    }
    // Truck has returned to warehouse
    else if (this.state.equals("Returning from Intersection") && isNear(this.position.x, this.roadOn.center.x - this.roadOn.radiusWidth)) {
      this.state = "Stationary";
      this.roadOn = null;
      this.position = restPosition.copy();
    }
   }
   
  // Method to find if the truck is near an x or y position
  boolean isNear(float truck, float road) {
    return truck - dT * simSpeed < road && truck + dT * simSpeed > road;
  }
  
  // Method to find the next closest street
  int locateNextStreet() {
    for (int idx = 0; idx < streetCount; idx++) {
      if (!this.packages.get(idx).isEmpty()) {
        return idx;
      }
    }
    return -1;
  }
  
  // Deliver package method
  void deliverPackage() {
    if (this.streetIdx == -1) {
      return;
    }
    Package item;
    ArrayList<Package> streetPackages = this.packages.get(streetIdx);
    for (int idx = 0; idx < streetPackages.size(); idx++) {
      item = streetPackages.get(idx);
      if (item.destination.position.x <= this.position.x) {
        streetPackages.remove(idx);
      }
    }
  }
  
  // Draw method
  void drawMe() {
    rectMode(CORNER);
    fill(0, 200, 0);    
    if (abs(this.velocity.x) > abs(this.velocity.y)) {
      rect(this.position.x, this.position.y, 20, 10);
    } else {
      rect(this.position.x, this.position.y, 10, 20);
    }
  }

  // Load package method
  // void loadPackage(Package item) {
    // Road street = item.destination.street;
    // int idx = streets.indexOf(street);
    // this.packages.get(idx).add(item);
    // this.load += item.weight;
  // }
}
