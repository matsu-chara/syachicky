require "syachicky/version"
require "json"
require "pp"
require "active_support/all"
require "sorry_yahoo_finance"

module Syachicky
    class Syachicky
        def initialize(bland, date=Date.today-36.hour, maxCacheDays=365*3)
        # 銘柄コード
        @bland = bland.to_i
        
        # 取得データ日
        @day = date
        @dayString = @day.strftime("%Y/%m/%d")
        
        # データの保持期間
        @maxCacheDays = maxCacheDays
        
        # 最終日データ
        @lastDayData = nil
        
        # dataディレクトリ
        @dataDir = File.expand_path(File.dirname(__FILE__)) + "/../data"
    end
    
    def dataUpdate
    	cleanupIfDataOverThreshold()
    	writeBlandData() unless isGotToday()
    end
    
    # foramt => '社名:#{syachiku["code"]}, 終値:#{syachiku["finish"]}'
    def printData(format=nil)
    	return unless @lastDayData
        
    	if format
    		syachiku = @lastDayData
    		puts eval('"' + format + '"')
        else
            pp @lastDayData
        end
        
    end
    
    def getData(format=nil)
    	return @lastDayData
    end
    
    private
    def isGotToday
    	return false unless File.exist?("#{@dataDir}/#{@bland}")
        
    	open("|tail -n 1 < #{@dataDir}/#{@bland}"){|file|
    		data = file.gets()
    		@lastDayData = JSON.parse(data) if data
    		result = @lastDayData["date"] if @lastDayData
    		return (@dayString == result)
    	}
    end
    
    def cleanupIfDataOverThreshold
    	return unless File.exist?("#{@dataDir}/#{@bland}")
        
    	open("|wc -l < #{@dataDir}/#{@bland}"){|file|
    		lines = file.gets().to_i
    		File.unlink("#{@dataDir}/#{@bland}") if lines > @maxCacheDays
    	}
    end
    
    def writeBlandData
    	info = SorryYahooFinance::GET(@bland, @day).values.stringify_keys!
    	info["date"] = @dayString
    	@lastDayData = info
        
    	Dir.mkdir("#{@dataDir}") unless Dir.exist?("#{@dataDir}")
    	File.open("#{@dataDir}/#{@bland}", "a"){|file|
    		file.puts(@lastDayData.to_json)
    	}
    end
end
end
