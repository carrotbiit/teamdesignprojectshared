import g4p_controls.*;
//Warehouse Manager

String[] options = {"2", "4", "6", "8", "10"};

//Parameters
int  numTrucks = 5;  //the number of shipping trucks
int  numWorkers = 10;  //the number of employees
int numHouses = 6;
int  numShelves = 6;  //the number of shelves in the warehouse

float  wage = 20;  //employee wage
float  gasPrice = 1.3;  //price of gas
float  totalWageExpense = 0;
float  totalGasExpense = 0;

int  truckMaxLoad = 1000;  //maximum carrying capacity of the truck
float truckSpeed = 0.1;

int  packageInRate = 10;  //the number of randomly generated packages added to the warehouse per minute
int  packageOutRate = 10;  //the number of randomly generated packages requested from the warehouse per minute

boolean  isPaused = false;  //if the simulation is paused or not
boolean showTrucks = true;
boolean showEmployees = true;
float  curTime = 0;  //the current time value
float  dT = 0.1;  //delta time
float  simSpeed = 1;  //multiplies delta time

int[] intChanges = {numTrucks, numWorkers, numHouses, numShelves, packageInRate, packageOutRate, truckMaxLoad};
float[] floatChanges = {wage, gasPrice, simSpeed};

// Number of objects
int streetCount = 9;

// House variables
int houseDistance = 12;
int houseSize = 10;

//User Interface variables
float  uiX = 200;  //the x coordinate of the right side/end of the UI

//Sim Graphics variables
float  spacer = 10;  //spacer for drawing
float  sW = 70;  //shelf width
float  sH = 10;  //shelf height



// Object variables
Warehouse Warehouse;
ArrayList<Shelf> Shelves = new ArrayList<Shelf>();
ArrayList<Worker>  Workers = new ArrayList<Worker>();
ArrayList<Road> streets = new ArrayList<Road>();
ArrayList<House> allHouses = new ArrayList<House>();
ArrayList<Package> allPackages = new ArrayList<Package>();
ArrayList<Truck> trucks = new ArrayList<Truck>();
Road warehouseIn, warehouseOut;
Road mergeRoad;

void  setup()  {
  size(700, 500);
  createGUI();
  numHousesDrop.setItems(options, 0);
  
  reset();
}

void  draw()  {
  background(0);
  
  //draw everything
  drawUI();
  drawSim();

  //update everything
  updatePackages();
  updateTrucks();
  updateWorkers();
}
