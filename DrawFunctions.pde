void drawUI() {
  noStroke();

  // UI rectangle
  fill(200);
  rectMode(CORNER);
  rect(0, 0, uiX, height);

  // Warehouse Manager title
  fill(255);
  textSize(30);
  textAlign(CENTER);
  text("Warehouse\nManager", uiX/2, 30);

  // Number of trucks and employees
  textSize(20);
  textAlign(LEFT);
  text("# of Trucks:  " + numTrucks, 10, 100);
  text("# of Employees:  " + numWorkers, 10, 120);

  // Expenses
  text("Total Gas Expenses", 10, 160);
  text("Total Labour Expenses", 10, 210);
  textAlign(RIGHT);
  text("\n$ " + roundAny( totalGasExpense, 2), uiX - 10, 160);
  text("\n$ " + roundAny( totalWageExpense, 2), uiX - 10, 210);


  //println(curTime);
}



void  drawSim() {

  noStroke();

  //draw the roads
  for (Road road : streets) {
    road.drawMe();
  }
  warehouseIn.drawMe();
  warehouseOut.drawMe();
  mergeRoad.drawMe();

  //draw the warehouse
  Warehouse.drawMe();

  noStroke();

  //draw the houses
  for (House house : allHouses) {
    house.drawMe();
  }

  //draw the trucks
  for (Truck truck : trucks) {
    truck.drawMe();
  }

  //draw the shelves
  for (Shelf shelf : Shelves) {
    shelf.drawMe();
  }

  //draw the workers
  for  (Worker worker : Workers) {
    worker.drawMe();
  }

  //draw the packages
}
