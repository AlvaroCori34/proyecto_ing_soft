class Square 
    def initialize()
        @object =  nil
    end
    def GetObject()
        return @object
    end
    def SetObject(obj)
        @object = obj
    end
    def GetType()
        yield
    end
end

