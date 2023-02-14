class PagesController < ApplicationController
  @@count = 0

  def home
    @input_string = params[:input_string]
    @result = ""
    @status = ""

    if !@input_string.nil?
      puts "count = #{@@count}"

      @input_string.downcase!

      input_string_parts = @input_string.split

      phrases = parse_phrases

      phrases.each do |phrase|
        if (input_string_parts - phrase).size > 1
          @@count += 1
          @result = "MATCH!"
          @status = "#{@@count} of 9 phrases found!"
          break
        end

        @result = "Try again..."
      end

      if @@count == 9
        @result = "YOU WIN! HERE IS THE SECRET MESSAGE:"
        @status = "I love you so much, Mar."
      end
    end

    puts "GOt here!"

    render
  end

  def parse_phrases
    I18n.t(:phrases).map { |phrase| phrase.split }
  end
end
