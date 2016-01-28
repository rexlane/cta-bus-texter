class Parser

  # def existing_methods
  #   ["map","define"]
  # end
  
  # def parse_incoming_string(string)
  #   request = string.split(" ", 2)
  #   requested_method = request[0].downcase
  #   if request[1]
  #     requested_arguments = request[1].downcase
  #   end

  #   if requested_method && requested_arguments
  #     method_name = permitted_method(requested_method)
  #   else
  #     method_name = "no_matching_method"
  #   end

  #   return method_name, requested_arguments

  # end

  # def permitted_method(requested_method)
  #   if existing_methods.include? requested_method
  #     return requested_method
  #   else
  #     "no_matching_method"
  #   end
  # end

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

  def define(args)
    if args.nil?
      return HelpMessage.new.no_matching_method, nil
    else
      return Definer.new.define(args), nil
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