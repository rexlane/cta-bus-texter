class Parser

  def existing_methods
    ["map","define","bus","help"]
  end
  
  def parse_incoming_string(string)
    request = string.split(" ", 2)
    r_method = request[0].downcase
    if request[1]
      r_arguments = request[1].downcase
    end

    if r_method && r_arguments
      r_method = permitted_method(r_method)
    else
      r_method = "no_matching_method"
      r_arguments = nil
    end

    return r_method, r_arguments
  end

  def permitted_method(r_method)
    if existing_methods.include? r_method
      return r_method
    else
      "no_matching_method"
    end
  end

  def map(args)
    Mapper.new.map(args)
  end

  def define(args)
    Mapper.new.define(args)
  end

  def bus(args)
    BusTracker.new.bus(args)
  end

  def help(args)
    HelpMessage.new.all_help(args)
  end

  # move out of Mapper
  def no_matching_method(args=nil)
    HelpMessage.new.error_message
  end

end