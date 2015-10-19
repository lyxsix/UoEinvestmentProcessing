Investment[] invests;
JSONObject json;
int gridSize = 80;
int windowWidth= 1120;
int windowHeight = 720;
float totalInvests;
String printStr;
PImage img;

void setup() {
  //Input Json
  json = loadJSONObject("investments.json");
  size(windowWidth, windowHeight); 
  img = loadImage("edUni.png");
}

void draw()
{
  //1.clear
  
  background(255,255,255); 
  textSize(32);
  text("University of Edinburgh Investment", 50,30);
  fill(50);
  image(img, 0, 0);
  
  //2.load Json
  JSONArray investData = json.getJSONArray("investments");
  invests = new Investment[investData.size()];
  
  //3.paint the rectangle
  int gridNum = 0;
  float maxAmount = 100000000;
  for (int x = gridSize; x <= width - gridSize; x += gridSize) {
    for (int y = gridSize; y <= height - gridSize; y += gridSize) {
    noStroke();
      JSONObject invest = investData.getJSONObject(gridNum);
      float amount = invest.getInt("amount");
      
      fill(0,0,0,15+amount*255/maxAmount);
      rect(x-gridSize/2, y-gridSize/2, gridSize*0.95, gridSize*0.95);
      
      if(gridNum<104){
            gridNum++;
            //x和y为grid(小方格)的坐标
            float tmpx = abs(x-mouseX);
            float tmpy = abs(y-mouseY);
            //小方格的一半加上大方格的一半 1*gridSize/2 + 1.5*gridSize/2 = 1.25*gridSize
            if((tmpx<1.25*gridSize)&(tmpy<1.25*gridSize)){
            totalInvests = totalInvests+amount;
            String iName = invest.getString("name");
            printStr += iName + "\n" + "= " +amount+"\n"; 
        }  
      }
      

    }
  }

  //Mouse with the big rectangle
  fill(255,0,0,totalInvests*255*2/maxAmount);
  //大方格为小方格的1.5倍
  rect(mouseX-gridSize*1.5/2,mouseY-gridSize*1.5/2,gridSize*1.5,gridSize*1.5);
  println("totalInvests is "+totalInvests);
  
  //Print Text
  
  float textX;
  float textY;
  fill(50);
  PFont font;
  font = createFont("FuturaBT-BoldItalic-48", 16);
  textFont(font);
  if(mouseX<windowWidth/2){
    textX = mouseX+windowWidth/8;
      
      if(mouseY<windowHeight/2){
        textY = mouseY;
      }else{
        textY = mouseY-windowHeight/3;
      }
      
  }else {
      textX = mouseX-windowWidth/8;
      
      if(mouseY<windowHeight/2){
        textY = mouseY;
      }else{
        textY = mouseY-windowHeight/3;
      }
      
  }
  text(printStr,textX,textY);
  
  printStr = "";  
  totalInvests = 0;

}


