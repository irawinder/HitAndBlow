import java.util.Map;

HitBlow game;
String guess;
String feedback;

List<String> guesses;
Map<String, String> feedbackMap;

int counter;
int MARGIN = 40;
int CURSOR_RATE = 60;
int TARGET_LENGTH = 4;
String DEFAULT_FEEDBACK = "Type a guess and press enter";
String DEFAULT_GUESS = "";

public void setup() {
  size(1280, 800);
  game = new HitBlow();
  feedback = DEFAULT_FEEDBACK;
  guess = DEFAULT_GUESS;
  guesses = new ArrayList<String>();
  feedbackMap = new HashMap<String, String>();
  
  counter = 0;
}

public void draw() {
  background(50);
  
  String title = "HIT & BLOW | by Ira & Miwa";
  
  String rules = "RULES\n\n\n";
  rules += "1. Guess a squence of " + game.getTarget().length + " symbols.\n\n";
  rules += "2. The answer may include any of the following symbols:\n\n";
  rules += "\t \t " + game.getSymbolsAsString() + "\n\n";
  rules += "3. The answer may use each symbol only once.\n\n";
  rules += "4. \"Hit\" means you correctly guessed the position and value for a symbol.\n\n";
  rules += "5. \"Blow\" means you correctly guessed a symbol, but not in the correct position.\n\n";
  rules += "6. Press \"r\" to reset game.";
  
  String console = "";
  console += "Sequence: " + game.targetGhost() + "\n\n";
  console += "Guess: " + guess;
  
  // Cursor
  if (counter > CURSOR_RATE/2) {
    console += "_";
  }
  if (counter > CURSOR_RATE) {
    counter = 0;
  }
  
  String guessHistory = "GUESS HISTORY\n\n" + "Guess\n\n";
  String feedbackHistory = "\n\n" + "Feedback\n\n";
  for (String g : guesses) {
    guessHistory += g + "\n";
    feedbackHistory += feedbackMap.get(g) + "\n";
  }
  
  fill(255);
  text(title, MARGIN, MARGIN);
  text(console, MARGIN, MARGIN + 40);
  text(rules, MARGIN, MARGIN + 190);
  text(guessHistory, 0.5 * width, MARGIN);
  text(feedbackHistory, 0.5 * width + 100, MARGIN);
  
  stroke(255);
  line(MARGIN, MARGIN - 15, 0.5 * width - MARGIN, MARGIN - 15);
  line(MARGIN, MARGIN + 05, 0.5 * width - MARGIN, MARGIN + 05);
  
  line(MARGIN, 190 + MARGIN - 15, 0.5 * width - MARGIN, 190 + MARGIN - 15);
  line(MARGIN, 190 + MARGIN + 05, 0.5 * width - MARGIN, 190 + MARGIN + 05);
  
  line(0.5 * width, MARGIN - 15, width - MARGIN, MARGIN - 15);
  line(0.5 * width, MARGIN + 05, width - MARGIN, MARGIN + 05);
  
  counter++;
}

public void keyPressed() {
  
  switch(key) {
    case 'r':
      
      break;
    case BACKSPACE:
      
  }
    
  if(key == 'r') {
    guess = DEFAULT_GUESS;
    feedback = DEFAULT_FEEDBACK;
    guesses.clear();
    feedbackMap.clear();
    game.initTarget(4);
  } else if (key == BACKSPACE) {
    if (guess.length() > 0) {
      guess = guess.substring(0, guess.length() - 2);
    }
  }
  else if (key == RETURN || key == ENTER) {
    feedback = game.evaluate(guess);
    String entryKey = "" + guess;
    String entry = "" + feedback;
    guesses.add(entryKey);
    feedbackMap.put(entryKey, entry);
    guess = DEFAULT_GUESS;
  } else {
   guess += key;
  }
}
