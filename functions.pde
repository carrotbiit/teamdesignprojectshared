void  drawUI()  {
  
  noStroke();
  
  fill(200);
  rectMode(CORNER);
  rect(0, 0, uiX, height);
  
  fill(255);
  textSize(30);
  textAlign(CENTER);
  text("Warehouse\nManager", uiX/2, 30);
  
  textSize(20);
  textAlign(LEFT);
  text("# of Trucks:  " + numTrucks, 10, 100);
  text("# of Employees:  " + numWorkers, 10, 120);
  
  text("Total Gas Expenses", 10, 160);
  text("Total Labour Expenses", 10, 210);
  textAlign(RIGHT);
  text("\n$ " + roundAny( totalGasExpense, 2), uiX - 10, 160);
  text("\n$ " + roundAny( totalWageExpense, 2), uiX - 10, 210);
  
  
  //println(curTime);
  
}

void  drawSim()  {
  
  //draw the warehouse
  Warehouse.drawWarehouse();
  
  //draw the shelves
  for  (shelf s: shelves)  {
    s.drawShelf();
  }
}

float  roundAny(float  num, int n)  { //decimal rounding function
  int p = int(  pow(10, n)  );
  return  float(round(num * p))/p;
}

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
  println(intChanges);
  println(floatChanges);
  println(isPaused);
  println(showTrucks);
  println(showEmployees);
}
