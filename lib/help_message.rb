class HelpMessage

  def sorry
    "Sorry, I don't understand."
  end

  def base_help_message
    "Try texting:"
  end

  def bus_help
    "bus [location] [direction]"
  end

  def define_help
    "define [word]"
  end

  def map_help
    "map [location]"
  end

  def all_help
    "#{base_help_message}<br/>#{bus_help}<br/>#{map_help}<br/>#{define_help}<br/>"
  end

  def error_message 
    "#{sorry} #{all_help}"
  end

end