float  roundAny(float  num, int n)  { //decimal rounding function
  int p = int(  pow(10, n)  );
  return  float(round(num * p))/p;
}

// Computes midpoint between two values 
// Used for road initialization
float midpoint(float point1, float point2) {
  return (point1 + point2) / 2;
}

float getNewAverage(float rating) {
  float newAverage = (averageRating  * numRatings + rating) / (numRatings + 1);
  numRatings++;
  return newAverage;
}


void updatePackages() {
  for (Package item : allPackages) {
    item.framesWaited += simSpeed;
  }
}

void updateTrucks() {
  for (Truck truck : trucks) {
    truck.move();
    truck.deliverPackage();
  }
  incomingTruck.move();
}

void  updateWorkers()  {
  for (Worker w : Workers) {
    w.update();
  }
}
