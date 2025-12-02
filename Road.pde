//Class to represent roads and streets
class  Road  {
  // Fields
  ArrayList<House> houses;
  PVector center;
  String orientation; // "Vertical" or "Horizontal"
  float radiusWidth, radiusHeight;
  
  
  // Constructor method
  Road(float centerX, float centerY, String orientation, float radiusWidth, float radiusHeight) {
    this.houses = new ArrayList<House>();
    this.center = new PVector(centerX, centerY);
    this.orientation = orientation;
    this.radiusWidth = radiusWidth;
    this.radiusHeight = radiusHeight;
  }
  
  // Add house method
  void addHouse() {
    int houseCount = this.houses.size();
    int level = houseCount / 2;
    float distance = this.center.x - this.radiusWidth + (level + 1) * (houseDistance + houseSize);
    House houseAbove = new House(this, distance, this.center.y - houseDistance);
    House houseBelow = new House(this, distance, this.center.y + this.radiusHeight);
    this.houses.add(houseAbove);
    this.houses.add(houseBelow);
    allHouses.add(houseAbove);
    allHouses.add(houseBelow);
  }
  
  // Draw method
  void drawMe() {
    fill(80);
    rectMode(RADIUS);
    rect(this.center.x, this.center.y, this.radiusWidth, this.radiusHeight);
    fill(200, 0, 0);
    circle(this.center.x, this.center.y, 10);
    drawLanes();
  }
  
  // Draw lanes
  void drawLanes() {
    float x, y;
    fill(255);
    rectMode(RADIUS);
    if (orientation.equals("Horizontal")) {
      x = this.center.x - this.radiusWidth + 2;
      y = this.center.y;
      for (int count = 0; count < this.radiusWidth / 8; count++) {
        rect(x, y, 4, 1);
        x += 16;
      }
    } else {
      x = this.center.x;
      y = this.center.y - this.radiusHeight + 2;
      for (int count = 0; count < this.radiusHeight / 8; count++) {
        rect(x, y, 1, 4);
        y += 16;
      }
    }
  }
}
