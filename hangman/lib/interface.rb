# frozen_string_literal: true

# the display for all of the interactions
module Interface
  RESET = "\x1b[39;49;00m"
  RED = "\x1b[31;01m"
  GREEN = "\x1b[32;01m"
  YELLOW = "\x1b[33;01m"
  BOLD = "\x1b[37;01m"

  def render_text(text = nil)
    print "\x1b[2J\x1b[H"
    starting_msg
    print text unless text.nil?
  end

  def starting_msg
    puts <<~HEREDOC
      #{BOLD}----- ----- ----- ----- ----- ----- ----- -----
          ▄ .▄ ▄▄▄·  ▐ ▄  ▄▄ • • ▌ ▄ ·.  ▄▄▄·  ▐ ▄ 
          ██▪▐█▐█ ▀█ •█▌▐█▐█ ▀ ▪·██ ▐███▪▐█ ▀█ •█▌▐█
          ██▀▀█▄█▀▀█ ▐█▐▐▌▄█ ▀█▄▐█ ▌▐▌▐█·▄█▀▀█ ▐█▐▐▌
          ██▌▐▀▐█▪ ▐▌██▐█▌▐█▄▪▐███ ██▌▐█▌▐█▪ ▐▌██▐█▌
          ▀▀▀ · ▀  ▀ ▀▀ █▪·▀▀▀▀ ▀▀  █▪▀▀▀ ▀  ▀ ▀▀ █▪
      ----- ----- ----- ----- ----- ----- ----- -----#{RESET}
    HEREDOC
  end

  def prompt(question)
    print "\n#{YELLOW}[ Q ]#{RESET} #{question}#{YELLOW} ⇒  #{RESET}"
    gets.chomp
  end

  def show_result(message, pass)
    puts "\n#{pass ? GREEN : RED}[ ¶ ]#{RESET} #{message}"
  end
end