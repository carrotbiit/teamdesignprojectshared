void loadRoads() {
  // Fields
  float x;
  float spacing = height / (streetCount + 1);
  float y = spacing;
  
  // Add the auxillary roads
  warehouseIn = new Road(Warehouse.pos.x - Warehouse.w  / 2 + 10, (Warehouse.pos.y - Warehouse.h / 2) / 2, "Vertical", 10, (Warehouse.pos.y - Warehouse.h / 2) / 2, false);
  warehouseOut = new Road(Warehouse.pos.x + Warehouse.w / 2 + 25, Warehouse.pos.y, "Horizontal", 25, 10, false);
  mergeRoad = new Road(warehouseOut.center.x + warehouseOut.radiusWidth + 10, Warehouse.pos.y, "Vertical", 10, height / 2 - spacing + 10, false);
  
  // Add streets
  x = midpoint(width, mergeRoad.center.x + mergeRoad.radiusWidth) - 20; // Between the merging road and the right edge of the screen
  for (int count = 0; count < streetCount; count++) {
    streets.add(new Road(x, y, "Horizontal", x - mergeRoad.center.x - mergeRoad.radiusWidth, 10, true));
    y += spacing;
  }
}

void loadHouses() {
  for (Road street : streets) {
    for (int houseCount = 0; houseCount < numHouses; houseCount += 2) {
      street.addHouse();
    }
  }
}

void loadTrucks() {
  float y;
  float x = Warehouse.pos.x + Warehouse.w / 2;
  float spacing = Warehouse.h / (numTrucks + 1);
  for (int count = 0; count < numTrucks; count++) {
    y = Warehouse.pos.y - (Warehouse.h / 2) + spacing * (count + 1);
    trucks.add(new Truck(null, x, y));
  }
}


void  loadShelves()  {
  for  (int i = 0; i < numShelves; i++)  {
    float  x  =  Warehouse.pos.x  -  (Warehouse.w/2)  +  spacer  +  (sW/2);
    float  y  =  Warehouse.pos.y  +  (Warehouse.h/2)  -  (spacer *  (numShelves - i))  -  (sH/2)  -  (sH * (numShelves - i - 1));
    Shelves.add(new  Shelf(  new  PVector( x, y)  ));
  }
}

void  loadWorkers()  {
  int  xN, yN;
  //xN = round(numWorkers/2);
  xN = int(sqrt(numWorkers));
  yN = int(numWorkers/xN);
  float x,y;
  
  for  (int i = 0; i < xN; i ++)  {
    for  (int j = 0; (j*xN) + i < numWorkers ; j++)  {
      x = j * 10;
      y = i * 10;
      
      //centering to the warehuse
      x += Warehouse.pos.x - (5 * xN);
      y += Warehouse.pos.y - (2.5 * yN);
      
      //moving them a bit
      y -= (Warehouse.h/3.5);
      
      Workers.add(new  Worker(  new  PVector( x, y )  ));
    }
  }
}
