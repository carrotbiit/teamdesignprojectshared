void applyChanges(){
  numTrucks = intChanges[0];
  numWorkers = intChanges[1];
  numHouses = intChanges[2];
  numShelves = intChanges[3];
  packageInRate = intChanges[4];
  packageOutRate = intChanges[5];
  truckMaxLoad = intChanges[6];
  
  wage = floatChanges[0];
  gasPrice = floatChanges[1];
  simSpeed = floatChanges[2];
}

void reset(){
  Warehouse = new Warehouse(new PVector(  ((width - uiX) / 4) + uiX,  height/2  ),  180,  260);
  
  Shelves = new ArrayList<Shelf>();
  Workers = new ArrayList<Worker>();
  streets = new ArrayList<Road>();
  allHouses = new ArrayList<House>();
  allPackages = new ArrayList<Package>();
  trucks = new ArrayList<Truck>();
  
  loadShelves();
  loadWorkers();
  loadRoads();
  loadHouses();
  loadTrucks();
  
  // TESTING
  trucks.get(3).leaveWarehouse();
  trucks.get(3).packages.get(1).add(new Package(allHouses.get(5), color(0), 1.5));
  trucks.get(3).packages.get(2).add(new Package(allHouses.get(9), color(0), 1.5));
  trucks.get(3).packages.get(5).add(new Package(allHouses.get(21), color(0), 1.5));
}

void createOrders() {
  House house;
  Package item;
  framesSinceOrder += simSpeed;
  if (framesSinceOrder < framesBetweenOrders) {
    return;
  }
  framesSinceOrder = 0;
  for (int count = 0; count < packageInRate; count++) {
    
    // item = new Package();
  }
}
