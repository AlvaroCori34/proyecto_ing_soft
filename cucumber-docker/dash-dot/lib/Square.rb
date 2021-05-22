class Square 
    def initialize()
        @object=nil

    end
    def GetObject()
        return @object
    end
    def GetType()
        return "cuadrilla"
    end
    def ExistAobjectInTheSquare()
        if (@object==nil)
            return false 
        end
    end
end

