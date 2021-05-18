class Square 
    def initialize()
        @object=nil

    end
    def GetObject()
        return @object
    end
    def ExistAobjectInTheSquare()
        if (@object==nil)
            return false 
        end
    end
end

