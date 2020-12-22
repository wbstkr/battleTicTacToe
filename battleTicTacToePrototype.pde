import java.util.Arrays;

tile[][] board;
int boardDim, size, turn;
String mode;

public void setup() {
  size( 640, 640 );
  boardDim = 4;
  setupBoard();
  size = 100;
  turn = 0;
  mode = "default";
}

public void draw() {
  background( 255 );
  rectMode( CENTER );
  for( int x = 0; x < board.length; x++ ) {
    for( int y = 0; y < board[x].length; y++ ) {
      float centerx = ( ( boardDim - 1f ) / 2f ) - x;
      float centery = ( ( boardDim - 1f ) / 2f ) - y;
      board[x][y].render( ( width / 2 ) - ( size * centerx ),
                          ( height / 2 ) - ( size * centery ),
                          size
                        );
    }
  }
  fill( 0 );
  textAlign( CENTER, CENTER );
  textSize( 10 );
  text( "( " + mouseX + ", " + mouseY + " )", width / 2, 10 );
  PVector position = canvasToBoard( new PVector( mouseX, mouseY ) );
  text( "( " + position.x + ", " + position.y + " )", width / 2, 25 );
  checkWin();
}

public void keyPressed() {
  if ( keyCode == UP ) {
    if ( boardDim < 6 ) {
      boardDim ++;
    }
    setupBoard();
  }
  if ( keyCode == DOWN ) {
    if ( boardDim > 2 ) {
      boardDim --;
    }
    setupBoard();
  }
}

public void setupBoard() {
  board = new tile[ boardDim ][ boardDim ];
  for( int x = 0; x < board.length; x++ ) {
    for( int y = 0; y < board[x].length; y++ ) {
      board[x][y] = new tile( x, y, ( int ) ( 4 * Math.random() ), 1 );
    }
  }
}

public PVector canvasToBoard( PVector coords ) {
  PVector output = new PVector( coords.x, coords.y );
  output.sub( ( width - ( size * boardDim ) ) / 2,
              ( height - ( size * boardDim ) ) / 2
            );
  output.set( ( int ) ( output.x / size ), ( int ) ( output.y / size ) );
  return output;
}

public void checkWin() {
  boolean win = false;

  fill( 0 );
  if ( win ) {
    text( "Win", width / 2, height - 10 );
  }
  else {
    text( "null", width / 2, height - 10 );
  }
}

public void mousePressed() {
  PVector position = canvasToBoard( new PVector( mouseX, mouseY ) );
  if ( position.x >= 0 && position.x < boardDim &&
       position.y >= 0 && position.y < boardDim
     ) {
    switch ( mode ) {
      case "erase":
        board[ ( int ) position.x ][ ( int ) position.y ] = new tile( ( int ) position.x, ( int ) position.y, ( int ) ( 4 * Math.random() ), 1 );
        mode = "default";
        if ( turn == 0 ) {
          turn = 1;
        }
        else {
          turn = 0;
        }
        break;
      default:
        if ( board[ ( int ) position.x ][ ( int ) position.y ].side == 0 ) {
          board[ ( int ) position.x ][ ( int ) position.y ].changeSide( turn + 1 );
          if ( board[ ( int ) position.x ][ ( int ) position.y ].spellName == "erase" ) {
            mode = "erase";
          }
          else {
            if ( turn == 0 ) {
              turn = 1;
            }
            else {
              turn = 0;
            }
          }
        } 
    }
  }
}
