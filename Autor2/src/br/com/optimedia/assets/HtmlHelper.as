package br.com.optimedia.assets
{
	public class HtmlHelper
	{
		
		public static function strip(html:String, tags:String = ""):String
		{
		    var tagsToBeKept:Array = new Array();
		    if (tags.length > 0)
		        tagsToBeKept = tags.split(new RegExp("\\s*,\\s*"));
		 
		    var tagsToKeep:Array = new Array();
		    for (var i:int = 0; i < tagsToBeKept.length; i++)
		    {
		        if (tagsToBeKept[i] != null && tagsToBeKept[i] != "")
		            tagsToKeep.push(tagsToBeKept[i]);
		    }
		 
		    var toBeRemoved:Array = new Array();
		    var tagRegExp:RegExp = new RegExp("<([^>\\s]+)(\\s[^>]+)*>", "g");
		 
		    var foundedStrings:Array = html.match(tagRegExp);
		    for (i = 0; i < foundedStrings.length; i++)
		    {
		        var tagFlag:Boolean = false;
		        if (tagsToKeep != null)
		        {
		            for (var j:int = 0; j < tagsToKeep.length; j++)
		            {
		                var tmpRegExp:RegExp = new RegExp("<\/?" + tagsToKeep[j] + " ?/?>", "i");
		                var tmpStr:String = foundedStrings[i] as String;
		                if (tmpStr.search(tmpRegExp) != -1)
		                    tagFlag = true;
		            }
		        }
		        if (!tagFlag)
		            toBeRemoved.push(foundedStrings[i]);
		    }
		    for (i = 0; i < toBeRemoved.length; i++)
		    {
		        var tmpRE:RegExp = new RegExp("([\+\*\$\/])","g");
		        var tmpRemRE:RegExp = new RegExp((toBeRemoved[i] as String).replace(tmpRE, "\\$1"),"g");
		        html = html.replace(tmpRemRE, "");
		    }
		    return html;
		}
		
		public static function calculateHtmlPosition(htmlstr:String, pos:int):int
		{
		    // we return -1 (not found) if the position is bad
		    if (pos <= -1)
		        return -1;
		 
		    // characters that appears when a tag starts
		    var openTags:Array = ["<","&"];
		    // characters that appears when a tag ends
		    var closeTags:Array = [">",";"];
		    // the tag should be replaced with
		    // ex: &amp; is & and has 1 as length but normal 
		    // tags have 0 length
		    var tagReplaceLength:Array = [0,1];
		    // flag to know when we are inside a tag
		    var isInsideTag:Boolean = false;
		    var cnt:int = 0;
		    // the id of the tag opening found
		    var tagId:int = -1;
		    var tagContent:String = "";
		 
		    for (var i:int = 0; i < htmlstr.length; i++)
		    {
		        // if the counter passes the position specified
		        // means that we reach the text position
		        if (cnt>=pos) 
		            break;
		        // current char	
		        var currentChar:String = htmlstr.charAt(i);
		        // checking if the current char is in the open tag array
		        for (var j:int = 0; j < openTags.length; j++)
		        {
		            if (currentChar == openTags[j])
		            {
		                // set flag
		                isInsideTag = true;
		                // store the tag open id
		                tagId = j;
		            }
		        }
		        if (!isInsideTag)
		        {
		            // increment the counter
		            cnt++;
		        } else {
		            // store the tag content
		            // needed afterwards to find new lines
		            tagContent += currentChar;
		        }
		        if (currentChar == closeTags[tagId]) {
		            // we ad the replace length 
		            if (tagId > -1) cnt += tagReplaceLength[tagId];
		            // if we encounter the </P> tag we increment the counter
		            // because of new line character
		            if (tagContent == "</P>") cnt++;
		            // set flag 
		            isInsideTag = false;
		            // reset tag content
		            tagContent = "";
		        }
		    }
		    // return de position in html text
		    return i;
		}
	}
	
}