public class tile {
  PVector location;
  int spellType, spellLevel, side;
  String spellName;
  color tileColor;
  
  public tile( int x, int y, int type, int level ) {
    location = new PVector( x, y );
    spellType = type;
    spellLevel = level;
    if ( spellLevel < 0 ) {
      spellLevel = 0;
    }
    setupSpellName( spellType );
    side = 0;
  }
  
  public void setupSpellName( int type ) {
    switch ( type ) {
      case 0:
        spellName = "blank";
        tileColor = color( 255 );
        break;
      case 1:
        spellName = "heal";
        tileColor = color( 0, 255, 0 );
        break;
      case 2:
        spellName = "attack";
        tileColor = color( 255, 0, 0 );
        break;
      case 3:
        spellName = "erase";
        tileColor = color( 0, 0, 255 );
        break;
      default:
        spellName = "blank";
        tileColor = color( 255 );
    }
  }
  
  public void changeSide( int who ) {
    side = who;
  }
  
  public void render( float x, float y, int size ) {
      fill( tileColor );
      stroke( 0 );
      strokeWeight( 5 );
      square( x, y, size );
      switch ( side ) {
        case 0:
          if ( spellType != 0 ) {
            fill( 255 );
            textSize( 20 );
            textAlign( CENTER, CENTER );
            text( spellName, x, y );
          }
          break;
        case 1:
          stroke( 0 );
          strokeWeight( 10 );
          line( x - ( 0.9 * size / 2 ), y - ( 0.9 * size / 2 ),
                x + ( 0.9 * size / 2 ), y + ( 0.9 * size / 2 )
              );
          line( x - ( 0.9 * size / 2 ), y + ( 0.9 * size / 2 ),
                x + ( 0.9 * size / 2 ), y - ( 0.9 * size / 2 )
              );
          break;
        case 2:
          stroke( 0 );
          strokeWeight( 10 );
          circle( x, y, 0.9 * size );
          break;
        default:
          if ( spellType != 0 ) {
            fill( 255 );
            textSize( 20 );
            textAlign( CENTER, CENTER );
            text( spellName, x, y );
          }
      }
  }
}
