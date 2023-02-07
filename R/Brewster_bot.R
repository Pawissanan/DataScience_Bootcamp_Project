brewster_bot <- function() {
  
  username = readline("What's your name: ")
  print("Brewster:")
  print(paste("Hi, my name is Brewster... welcome to The Roost, ", username))
  print("Care for some coffee? It's 200 Bells a cup...")

## Care for some coffee?
  print("A: Absolotely! B: Maybe later.")
  answer = readline("Your answer: ")
  if (answer == "A") {
    print("Brewster: Sure.")
    print("I brewed this cup...especially for you... Drink up. Coo...")
    
## Action 1 
    print("A: I'll just do that! B:It way too hot.")
    answer2 = readline("Your answer: ")
    if (answer2 == "A") {
      print("It just a bit bitter... And that's how I like!")
      print("Brewster:")
      print("Just becareful... Too much coffee can mess with you...")
    } else {
      print("Brewster:...")
      
## Action 2  
      print("A: OK, coffee time B: It's still too hot. ")
      answer3 = readline("Your answer: ")
      if (answer3 == "A") {
        print("Oh, WOW! The depth of flavor expands at this cooler temperature.")
        print("Brewster:")
        print("Just becareful... Too much coffee can mess with you...")
      } else {
        print("Brewster:......")
        
## Action 3 
        print("A: OK, coffee time B: It's still too hot. ")
        answer4 = readline("Your answer: ")
        if (answer4 == "A") {
          print("Mmm... It goes down nice and mellow when it's cooled down a little bit")
          print("Brewster:")
          print("Just becareful... Too much coffee can mess with you...")
        } else {
          print("Brewster:")
          print("I get the sence that you like your coffee... on the lukewarm side...")
          
## Let coffee loop
          while (TRUE) {
            print("A: OK, coffee time B: Let's it cool. ")
            answer5 = readline("Your answer: ")
            if (answer5 == "A") {
              print("Absolute Perfection!")
              print("Brewster knows what he's doing. The perfect cup...even at room temp.")
              print("Brewster: ")
              print("Just becareful... Too much coffee can mess with you...")
              break
            } else {
              print("Brewster: ......")
            }
          }
        }
      }
    }
    } else {
    print("Coo... When you want coffee, you know who to ask")
  }
}  
