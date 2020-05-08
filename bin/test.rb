require 'pry'
$prompt = TTY::Prompt.new
def ask_away
answer = $prompt.yes?("Do you love me?")
binding.pry
answer
end 

ask_away