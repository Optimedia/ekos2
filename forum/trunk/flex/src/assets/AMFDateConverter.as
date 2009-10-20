package assets
{
	import mx.formatters.DateFormatter;
	
	public class AMFDateConverter
	{
	 
	    public static function convert(value:*):Date
	    {
	        if (value is Number)
	        {
	            // The backend value is based in milliseconds, which is PHP's
	            // Unix timestamp multiplied by 1000.
	            return new Date(value as Number);
	        }
	        else if (value is String)
	        {
	            var millis:Number = parseInt(value);
	 
	            // Are milliseconds typed as a String?
	            if (isNaN(millis))
	            {
	                // The date string is empty so return null
	                if (value == "")
	                {
	                    return null;
	                }
	 
	                // Check to see if it is UTC format...
	                var df:DateFormatter = new DateFormatter();
	                df.formatString = "MM/DD/YYYY LL:NN:SS A";
	 
	                return new Date(df.format(value));
	            }
	            else
	            {
	                return new Date(millis);
	            }
	        }
	        else if (value is Date)
	        {
	            // If it is a Date, just return it (for internal use).
	            return value as Date;
	        }
	        else
	        {
	            return null;
	        }
	    }
	 
	}
}