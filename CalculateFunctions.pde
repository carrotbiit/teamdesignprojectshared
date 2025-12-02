float  roundAny(float  num, int n)  { //decimal rounding function
  int p = int(  pow(10, n)  );
  return  float(round(num * p))/p;
}


void updatePackages() {
  for (Package item : allPackages) {
    item.framesWaited++;
  }
}

void updateTrucks() {
  for (Truck truck : trucks) {
    truck.move();
    truck.deliverPackage();
  }
}

void  updateWorkers()  {
  for (Worker w : Workers) {
    w.update();
  }
}
