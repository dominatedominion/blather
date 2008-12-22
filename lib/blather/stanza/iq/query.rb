module Blather
class Stanza
class Iq

  class Query < Iq
    register :query, :query

    ##
    # Ensure the namespace is set to the query node
    def initialize(type = nil)
      super
      query.xmlns = self.class.xmlns
    end

    ##
    # Kill the query node before running inherit
    def inherit(node)
      query.remove!
      @query = nil
      super
    end

    ##
    # Query node accessor
    # This will ensure there actually is a query node
    def query
      (self << (q = XMPPNode.new('query'))) unless q = find_first('query')
      q
    end

    ##
    # A query reply should have type set to "result"
    def reply
      elem = super
      elem.type = :result
      elem
    end

    ##
    # A query reply should have type set to "result"
    def reply!
      self.type = :result
      super
    end
  end #Query

end #Iq
end #Stanza
end