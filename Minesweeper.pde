import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private final static int NUM_BOMS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER,CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
  }
  
    setMines();
}
public void setMines()
{
  for(int i = 0; i < NUM_BOMS;i++){
    int row = (int)(random(NUM_ROWS));
    int col = (int)(random(NUM_COLS));
    if (!mines.contains(buttons[row][col]))
      mines.add(buttons[row][col]);
    
  }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    int markMine= 0;
    for(int i = 0; i < mines.size(); i++)
    {
        if(mines.get(i).isFlagged() == true)
        {
            markMine++;
        }
    }
    if(markMine == mines.size())
    {
        return true;
    }
    for(int i = 0;i < mines.size(); i++)
    {
        if(mines.get(i).isClicked() == true)
        {
            displayLosingMessage();
        }
    }
    return false;
}
public void displayLosingMessage()
{
    //your code here
    /*String lose = " You Lose!BOOOO";
    for(int i = 0; i < mines.size();i++){
      mines.get(i).setClicked(true);
    }
    for (int i = 1; i < NUM_COLS; i++) {
     
      buttons[NUM_COLS / 2][i].setLabel(lose.substring(i-1, i));
    }*/
    //your code here
     for(int i=0;i<mines.size();i++)
    {
        mines.get(i).setClicked(true);
    }
    buttons[10][6].setLabel("Y");
    buttons[10][7].setLabel("O");
    buttons[10][8].setLabel("U");
    buttons[10][9].setLabel("L");
    buttons[10][10].setLabel("O");
    buttons[10][11].setLabel("S");
    buttons[10][12].setLabel("E");
    buttons[10][13].setLabel("!");
}
public void displayWinningMessage()
{
    buttons[10][7].setLabel("Y");
    buttons[10][8].setLabel("O");
    buttons[10][9].setLabel("U");
    buttons[10][10].setLabel("W");
    buttons[10][11].setLabel("I");
    buttons[10][12].setLabel("N");
    buttons[10][13].setLabel("!");
}


public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
   
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col;
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        if(mouseButton == LEFT)
        {
            if(clicked == false)
            {
                clicked = true;
                if(keyPressed == true)
                {
                    flagged = !flagged;
                }
                else if(mines.contains(this))
                {
                    displayLosingMessage();
                }
                else if(countMines(myRow,myCol)>0)
                {
                    myLabel = myLabel + countMines(myRow,myCol);
                    //println("label");
                }
                else
                {
                    for(int i=-1;i<2;i++)
                    {
                        for(int j=-1;j<2;j++)
                        {
                            if(isValid(myRow+i,myCol+j)==true)
                            {
                                if(buttons[myRow+i][myCol+j].isClicked()==false)
                                {
                                    buttons[myRow+i][myCol+j].mousePressed();
                                }
                            }
                        }
                    }
                }
            }
        }
        if(mouseButton==RIGHT)
        {
            if(clicked == false)
            {
                flagged=!flagged;
            }
        }
    }
    public void draw ()
    {    
        if (flagged)
            fill(94, 124, 96);
         else if( clicked && mines.contains(this) )
             fill(222,159,174);
        else if(clicked)
            fill(155,205,232 );
        else
            fill(26,75,100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
    public boolean isClicked()
    {
        return clicked;
       
    }
    public void setClicked(boolean Kicckled){
        clicked = Kicckled;
    }
    public boolean isValid(int r, int c)
    {
    //your code here
    if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
      return true;
    return false;
    }
    public int countMines(int row, int col)
    {
        int numMines = 0;
        for(int i=-1;i<2;i++)
        {
            for(int j=-1;j<2;j++)
            {
                if(isValid(row+i,col+j)==true)
                {
                    if(mines.contains(buttons[row+i][col+j]))
                    {
                        numMines++;
                    }
                }
            }
        }
        return numMines;
    }
}


