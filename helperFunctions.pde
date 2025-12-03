void applyChanges(){
  numTrucks = intChanges[0];
  numWorkers = intChanges[1];
  numHouses = intChanges[2];
  numShelves = intChanges[3];
  packageOutRate = intChanges[4];
  truckMaxLoad = intChanges[5];
  
  wage = floatChanges[0];
  gasPrice = floatChanges[1];
  simSpeed = floatChanges[2];
}

void reset(){
  
  totalWageExpense = 0;
  totalGasExpense = 0;
  totalProfit = 0;
  
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
  // Variable declarations
  House house;
  Package item;
  color colour;
  float weight;
  
  // Increment the number of waited time
  framesSinceOrder += simSpeed;
  if (framesSinceOrder < framesBetweenOrders) {
    return;
  }
  
  // Create new packages
  framesSinceOrder = 0;
  for (int count = 0; count < packageOutRate; count++) {
    house = allHouses.get(int(random(allHouses.size())));
    colour = color(random(255), random(255), random(255));
    weight = random(maxPackageWeight - minPackageWeight) + minPackageWeight;
    item = new Package(house, colour, weight);
    allPackages.add(item);
    house.ordered.add(item);
    incomingTruck.packages.get(0).add(item);
  }
  incomingTruck.shipToWarehouse();
}
