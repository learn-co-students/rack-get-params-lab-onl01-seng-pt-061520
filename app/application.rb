class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)              #responds with empty cart message if the cart is empty
      if @@cart.empty?                        #responds with empty cart message if the cart is empty
        resp.write "Your cart is empty"       #responds with empty cart message if the cart is empty
      else
        @@cart.each do |item|                 #responds with a cart list if there is something in there
          resp.write "#{item}\n"              #responds with a cart list if there is something in there
        end
      end
    elsif req.path.match(/add/)               #Will add an item that is in the @@items list
      search_term = req.params["item"]        #Will add an item that is in the @@items list
      if @@items.include?(search_term)        #Will add an item that is in the @@items list
        @@cart << search_term                 #Will add an item that is in the @@items list
        resp.write "added #{search_term}"     #Will add an item that is in the @@items list
      else
        resp.write "We don't have that item"  #Will not add an item that is not in the @@items list
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
