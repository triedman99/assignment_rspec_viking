class Warmup
 
  # This is a user input and command-line-output
  #   test.  You need to stub out `gets` to make it work
  # And can stub out `puts` just for fun
  def gets_shout
    shout = gets.chomp.upcase

    # This is a side effect. Test it if you'd like!
    # (optional).  
    puts shout

    return shout
  end
  

  # For your spec for this one, pass in a plain old double
  #   that can accept a #size method and return something
  # Otherwise, treat is as any other test (this should be
  #   an equality test, e.g. expect(...).to eq(...))
  def triple_size(array)
    return array.size * 3
  end

  
  # Tricky! This method has side effects.  Pay attention to
  #   which object each method is called on.  Remember that
  #   "bang!" methods are in-place (destructive).
  #
  # For this method, write separate tests to show:
  #   1. The string you pass in receives the #upcase!
  #       method call, 
  #   2. The string you pass in receives the #reverse! 
  #      method call,
  #   3. Your method actually returns a completely different
  #       object than the one you passed in
  def calls_some_methods(string)
    raise "Hey, give me a string!" if string.empty?
    loud_string = string.upcase!
    loud_string.reverse!
    return "I am unrelated"
  end

 end
