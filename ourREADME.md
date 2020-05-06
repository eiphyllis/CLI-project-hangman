a short description,
 install instructions, 
 a contributors guide 
 and a link to the license for your code.

 # welcome message
puts "Welcome to hangman!"
menu # menu
    # ask and save user as new if not already found 
     #new_game: new instance of game with num_guesses and guesses_remaining fresh
         # generate random word  # save that word as the answer
    # answer_array = split that answer so we have something to iterate/compare
    # create progress_array that replaces all the chars in answer_array with _
game_play
    # while !game_over
         # single_play: 
                    # print progress_array and guesses_remaining left to terminal
                    # do you want to guess the word?
                        # if y
                            # check_word_guess(user_input)  
                            # if correct
                                # game_over becomes true bc progress_answer == answer_array now as updated by check_word_guess
                    # ask user for a letter guess  
                    # user enters letter guess
                    # check their input against the answer_array
                        #if found, 
                            # say "getting closer"
                            #  "reveal" that index in the progress_array
                        #if not found, say "nope"
                    # decrement guesses_remaining