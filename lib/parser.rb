class Parser

  def existing_methods
    ["map","define","bus","helpme"]
  end
  
  def parse_incoming_string(string)
    request = string.split(" ", 2)
    r_method = request[0].downcase


    if request[1]
      r_arguments = request[1].downcase
    else
      r_arguments = nil
    end

    # change where this is checked; make part of individual methods?
    # if r_method && r_arguments
    #   r_method = permitted_method(r_method)
    # else
    #   r_method = "no_matching_method"
    #   r_arguments = nil
    # end

    r_method = permitted_method(r_method)

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
    if args.nil?
      return HelpMessage.new.no_matching_method, nil
    else
      # returns two values
      Mapper.new.map(args)
    end
  end

  # move out of Mapper
  def define(args)
    if args.nil?
      return HelpMessage.new.no_matching_method, nil
    else
      return Mapper.new.define(args), nil
    end
  end

  def bus(args)
    if args.nil?
      return HelpMessage.new.no_matching_method, nil
    else
      return BusTracker.new.bus(args), nil
    end
  end

  def helpme(args=nil)
    return HelpMessage.new.all_help, nil
  end

  def no_matching_method(args=nil)
    return HelpMessage.new.no_matching_method, nil
  end

end