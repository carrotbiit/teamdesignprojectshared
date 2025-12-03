// Class to represent packages that get shipped
class  Package  {
  // Fields
  House destination;
  color colour;
  String status; // "To warehouse", "In warehouse", "On road", "Shipped"
  float weight;
  int urgency; // number of frames until house's satisfaction reduces by 0.1
  int framesWaited;
  
  // Constructor method
  Package(House destination, color colour, float weight) {
    this.destination = destination;
    this.colour = colour;
    this.status = "to warehouse";
    this.weight = weight;
    this.urgency = 10;
    this.framesWaited = 0;
  }
  
  // Satisfaction rating between 1 and 5
  float getSatisfaction() {
    return max(5 - this.framesWaited / this.urgency * 0.1, 1);
  }
}
