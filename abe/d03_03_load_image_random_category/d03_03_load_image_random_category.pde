String category;
if(random(100) < 50) {
  category = "nature";
} else {
  category = "sports";
}
println(category);
PImage myImage = loadImage("http://lorempixel.com/400/400/" + 
  category +"/#.jpg"); 
  
image(myImage, 0, 0, 100, 100);
