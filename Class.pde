import java.lang.Math;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class HitBlow {
  private String[] target, symbols;
  private int DEFAULT_LENGTH = 4;
  private String[] DEFAULT_SYMBOLS = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
  private boolean solved;
  
  public HitBlow() {
    this.symbols = DEFAULT_SYMBOLS;
    this.initTarget(DEFAULT_LENGTH);
  }
  
  public void setSymbols(String[] symbols) {
    this.symbols = symbols;
  }
  
  public String[] getTarget() {
    return this.target;
  }
  
  public void initTarget(int length) {
    if (length > this.symbols.length) {
      System.out.println("There are not enough symbols to accommodate a target this long");
    } else {
      int max = this.symbols.length - 1;
      int min = 0;
      int range = max - min + 1;
      List<String> used = new ArrayList<String>();
      
      this.target = new String[length];
      for (int i=0; i<length; i++) {
        String symbol = null;
        while (used.contains(symbol) || symbol == null) {
          int randomIndex = (int)(Math.random() * range) + min;
          symbol = this.symbols[randomIndex];
        }
        used.add(symbol);
        this.target[i] = symbol;
      }
      this.solved = false;
    }
  }
  
  public String getTargetAsString() {
    return this.ArrayToString(this.target);
  }
  
  public String getSymbolsAsString() {
    return this.ArrayToString(this.symbols);
  }
  
  private String ArrayToString(String[] array) {
    String result = "";
    for(int i=0; i<array.length; i++) {
      result += array[i];
      if(i != array.length-1) result += " ";
    }
    return result;
  }
  
  private String errorCheck(String[] guess) {
    // check for target initialized
    if (this.target == null) {
      return "You must first initialize a target to guess";
    }
    
    // check for array length
    if (this.target.length != guess.length) {
      return "Guess must be " + this.target.length + " symbols long";
    }
    
    // Iterate through each character in the guess array
    List<String> symbolList = new ArrayList<>(Arrays.asList(this.symbols));
    List<String> guessList = new ArrayList<String>();
    for (int i=0; i<guess.length; i++) {
      
      // check for correct symbols
      if (!symbolList.contains(guess[i])) {
        return "Symbol \"" + guess[i] + "\" is not allowed";
      }
      
      // check for repeat symbols
      if (guessList.contains(guess[i])) {
        return "The symbol \"" + guess[i] + "\" is not allowed to be used more than once";
      } else {
        guessList.add(guess[i]);
      }
    }
    
    return null;
  }
  
  public String errorCheck(String guess) {
    return errorCheck(this.toArray(guess));
  }
  
  public String evaluate(String guess) {
    
    String[] guessArray = this.toArray(guess);
    
    // Check for errors in the input first
    String error = this.errorCheck(guessArray);
    if(error != null) {
      return error;
    }
    
    // Evaluate Hits and Blows
    int hits = 0;
    int blows = 0;
    for (int i=0; i<guessArray.length; i++) {
      
      // Evaluate "hits"
      if (guessArray[i].equals(this.target[i])) {
        hits++;
      }
      
      // Evaluate "blows"
      for (int j=0; j<this.target.length; j++) {
        if (i != j) {
          if (guessArray[i].equals(this.target[j])) {
              blows++;
          }
        }
      }
    }
    
    // Did you get it?
    if (hits == this.target.length) {
      this.solved = true;
      return "Boy howdy, you got the answer!";
    }
    
    return "Hits: " + hits + "; Blows: " + blows;
  }
  
  private String[] toArray(String guess) {
    String[] guessArray = new String[guess.length()];
    for(int i=0; i<guess.length(); i++) {
      guessArray[i] = guess.substring(i, i+1);
    }
    return guessArray;
  }
  
  public String targetGhost() {
    if (solved) {
      return this.getTargetAsString();
    } else {
      String ghost = "";
      for(int i=0; i<this.target.length; i++) {
        ghost += "*";
        if (i < this.target.length - 1) ghost += " ";
      }
      return ghost;
    }
  }
}
