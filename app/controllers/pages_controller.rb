class PagesController < ApplicationController
  @@count = -1
  @@messages = {}
  @@phrases = []

  def home
    # Initialization
    @love_letter = []
    if @@count == -1
      @@count = 0
      @@phrases = parse_phrases
      return render layout: false
    end
    
    input_string = params[:input_string]

    # Check that the user actually put a string in the box
    if !input_string.nil?
      if input_string.empty?
        @result = "You didn't enter an answer..."
      
      else
        input_string.downcase!
        input_string_words = input_string.split
        match = false

        @@phrases.each do |phrase|
          input_string_words.each do |word|
            if phrase.include?(word)
              @@count += 1
              @result = "MATCH: #{phrase.join(" ")}"
              match = true
              break
            end
            break if match
          end

          break if match
          
          @result = "Try again!"
        end
      end
    end
    
    if @@count >= @@phrases.size
      update_for_endgame
      return render layout: false
    end

    update_status
    render layout: false
  end
  
  def update_for_endgame
    @result = "YOU WIN! Here is the secret message:"
    @status = ""
    @love_letter = I18n.t(:love_letter).map { |line| line }
  end

  def update_status
    @status = "#{@@count} of #{@@phrases.size} phrases found."
  end

  def parse_phrases
    I18n.t(:phrases).map { |phrase| phrase.split }
  end
end
