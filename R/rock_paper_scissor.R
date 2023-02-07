start_game <- function() {
  
  print("Instruction: type 'exit' to stop the game")
  options <- c("rock", "paper", "scissor")
  
  player <- 0
  cpu <- 0
  
  while (TRUE) {
    
    print(options)
    user_select <- readline("Choose one: ")
    computer_select <- sample(options, 1)
    
    ## win scenario
    if (user_select == "rock" & computer_select == "scissor") {
      print("you win!")
      player <- player + 1
    } 
      else if (user_select == "scissor" & computer_select == "paper") {
      print("you win!")
      player <- player + 1
    } 
      else if (user_select == "paper" & computer_select == "rock") {
      print("you win!")
      player <- player + 1
    } 
    
    ## lose scenario
      else if (computer_select == "rock" & user_select == "scissor") {
      print("you lose")
      cpu <- cpu + 1
    } 
      else if (computer_select == "scissor" & user_select == "paper") {
      print("you lose")
      cpu <- cpu + 1
    } 
      else if (computer_select == "paper" & user_select == "rock") {
      print("you lose")
      cpu <- cpu + 1
    } 
      else if (user_select == "exit") {
      print("Thank you for playing!")
      break
    }
      else {
      print("tie!")
    }
  } 
  
  ## score board
  print(player)
  print(cpu)
}
