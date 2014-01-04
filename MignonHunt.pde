#include <gamekit_2_1.h>
#include <avr/pgmspace.h>

/*
to load a map it has to be "drawn" at first
 
 The declaration begins always with:
 
 uint8_t name[rows][columns] PROGMEM = {
 
 where "name" is the name of the map,
 rows is the number of rows
 columns is the number of columns
 
 then a list of brightness values (or values assigned to pixelfunctions) follows.
 It is smart, but not necessary, to align the rows for better readability.
 
 */

// sets the value for a blinking pixel
const uint8_t bp = 16;


const int rows = 5;
const int columns = 34;

int dotrow = 2;
int dotcol = 3;

// This will write .......HUNT.......
uint8_t matrix[rows][columns] PROGMEM = {
  0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,15 ,0 ,0 ,15,0 ,15,0 ,0 ,15,0,15,0 ,0 ,0 ,15,0 ,15,15,15,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
  0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,15 ,0 ,0 ,15,0 ,15,0 ,0 ,15,0,15,15,0 ,0 ,15,0 ,0 ,15,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
  0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,15 ,15,15,15,0 ,15,0, 0 ,15,0,15,0 ,15,0 ,15,0 ,0 ,15,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
  0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,15 ,0 ,0 ,15,0 ,15,0 ,0 ,15,0,15,0 ,0 ,15,15,0 ,0 ,15,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
  0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,15 ,0 ,0 ,15,0 ,0 ,15,15,0 ,0,15,0 ,0 ,0 ,15,0 ,0 ,15,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
};


uint8_t sonar_pic_0[5][7] PROGMEM = {
 0 ,0 ,0 ,0 ,0 ,0, 0,
 0 ,0 ,0 ,0 ,0 ,0, 0,
 0 ,0 ,0 ,0 ,0 ,0, 0,
 0 ,0 ,0 ,0 ,0 ,0, 0,
 0 ,0 ,0 ,0 ,0 ,0, 0
 };

uint8_t sonar_pic_1[5][7] PROGMEM = {
 0 ,0 ,0 ,0 ,0 ,0, 0,
 0 ,0 ,0 ,0 ,0 ,0, 0,
 0 ,0 ,0 ,bp,0 ,0, 0,
 0 ,0 ,0 ,0 ,0 ,0, 0,
 0 ,0 ,0 ,0 ,0 ,0, 0
 };
 
uint8_t sonar_pic_2[5][7] PROGMEM = {
 0 ,0 ,0 ,0 ,0 ,0, 0,
 0 ,0 ,0 ,bp,0 ,0, 0,
 0 ,0 ,bp,0 ,bp,0, 0,
 0 ,0 ,0 ,bp,0 ,0, 0,
 0 ,0 ,0 ,0 ,0 ,0, 0
 };

uint8_t sonar_pic_3[5][7] PROGMEM = {
 0 ,0 ,bp,bp,bp,0, 0,
 0 ,bp,0 ,0 ,0 ,bp,0,
 0 ,bp,0 ,0 ,0 ,bp,0,
 0 ,bp,0 ,0 ,0 ,bp,0,
 0 ,0 ,bp,bp,bp,0, 0
 };

uint8_t sonar_pic_4[5][7] PROGMEM = {
 0 ,bp,0 ,0 ,0 ,bp,0 ,
 bp,0 ,0 ,0 ,0 ,0 ,bp,
 bp,0 ,0 ,0 ,0 ,0, bp,
 bp,0 ,0 ,0 ,0 ,0, bp,
 0 ,bp,0 ,0 ,0 ,bp, 0
 };

void setup(){
  gamekit.Begin();
  //display_title();
}


/*
a cutout of the map (wich has to be larger than the display) is loaded with the gamekit.load_map funtion and the following arguments:
 
 gamekit.load_map( (uint_t *) name, rows, columns, row_offset, column_offset)
 
 name: this is the name of the image, (uint_t *) has to be be added always
 rows: the number rows of the whole map 
 columns: the number columns of the whole map 
 these three can be found in the declaration of the map
 
 row_offset
 column_offset
 are the distances from the upper and left borders of the map to the region to be loaded.
*/



void loop() {

  if (dotcol < 0) dotcol = 0;
  if (dotcol >= 7) dotcol = 6;
  if (dotrow < 0) dotrow = 0;
  if (dotrow >= 5) dotrow = 4;
 
  gamekit.set_pixel(dotrow, dotcol, 15);
  
  if (gamekit.button_pressed(butt_UP)) {
    gamekit.set_pixel(dotrow, dotcol, 0);
    dotrow--;
  }  
  
    if (gamekit.button_pressed(butt_DOWN)) {
    gamekit.set_pixel(dotrow, dotcol, 0);
    dotrow++;
  }  

  if (gamekit.button_pressed(butt_LEFT)) {
    gamekit.set_pixel(dotrow, dotcol, 0);
    dotcol--;
  }  

  if (gamekit.button_pressed(butt_RIGHT)) {
    gamekit.set_pixel(dotrow, dotcol, 0);
    dotcol++;
  }  

  if (gamekit.button_pressed(butt_FUNCA)) {
    display_sonar();
  }  

}

void display_title() {

  uint8_t i = 0;
  for (i = 0; i < columns; i++) {
    gamekit.load_map( (uint8_t *) matrix, rows, columns, 0, i);
    delay(200);
  }

}

void display_sonar() {
  
  const int dely = 600;
  
  gamekit.load_image(sonar_pic_1);
  delay(dely);
  gamekit.load_image(sonar_pic_2);
  delay(dely);
  gamekit.load_image(sonar_pic_3);
  delay(dely);
  gamekit.load_image(sonar_pic_4);
  delay(dely);
  gamekit.load_image(sonar_pic_0);

}
