<cfcomponent output="false" displayname="UDF" hint="">

<cffunction name="init" returntype="UDF" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="getSimpleValuesFromStruct" returntype="struct" access="public" output="false" hint="I return only simple value from the passed structure.">
	<cfargument name="values" type="struct" required="true" hint="" />
	<cfset var ret = StructNew() />
	<cfset var i =  "" />
	<cfloop collection="#arguments.values#" item="i">
		<cfif IsSimpleValue( arguments.values[i] )>
			<cfset ret[i] = arguments.values[i] />
		</cfif>
	</cfloop>
	<cfreturn ret />
</cffunction>

<cffunction name="format" returntype="string" access="public" output="false" hint="">
	<cfargument name="value" type="string" required="true" hint="" />
	<cfif isDate( arguments.value )>
		<cfreturn DateFormat( arguments.value, 'mm/dd/yyyy' )>
	</cfif>
	<cfreturn value />
</cffunction>

<cfscript>
/**
 * Returns a string with words capitalized for a title.
 * Modified by Ray Camden to include var statements.
 * 
 * @param initText 	 String to be modified. 
 * @return Returns a string. 
 * @author Ed Hodder (ed.hodder@bowne.com) 
 * @version 2, July 27, 2001 
 */
function capFirstTitle(initText){
	
	var Words = "";
	var j = 1; var m = 1;
	var doCap = "";
	var thisWord = "";
	var excludeWords = ArrayNew(1);
	var outputString = "";
	
	initText = LCASE(initText);
	
	//Words to never capitalize
	excludeWords[1] = "an";
	excludeWords[2] = "the";
	excludeWords[3] = "at";
	excludeWords[4] = "by";
	excludeWords[5] = "for";
	excludeWords[6] = "of";
	excludeWords[7] = "in";
	excludeWords[8] = "up";
	excludeWords[9] = "on";
	excludeWords[10] = "to";
	excludeWords[11] = "and";
	excludeWords[12] = "as";
	excludeWords[13] = "but";
	excludeWords[14] = "if";
	excludeWords[15] = "or";
	excludeWords[16] = "nor";
	excludeWords[17] = "a";
	
	//Make each word in text an array variable
		
	Words = ListToArray(initText, " ");
	
	//Check words against exclude list
	for(j=1; j LTE (ArrayLen(Words)); j = j+1){
		doCap = true;
		
		//Word must be less that four characters to be in the list of excluded words
		if(LEN(Words[j]) LT 4 ){
			if(ListFind(ArrayToList(excludeWords,","),Words[j])){
				doCap = false;
			}
		}

		//Capitalize hyphenated words	
		if(ListLen(Words[j],"-") GT 1){
			for(m=2; m LTE ListLen(Words[j], "-"); m=m+1){
				thisWord = ListGetAt(Words[j], m, "-");
				thisWord = UCase(Mid(thisWord,1, 1)) & Mid(thisWord,2, LEN(thisWord)-1);
				Words[j] = ListSetAt(Words[j], m, thisWord, "-");
			}
		}
		
		//Automatically capitalize first and last words
		if(j eq 1 or j eq ArrayLen(Words)){
			doCap = true;
		}
		
		//Capitalize qualifying words
		if(doCap){
			Words[j] = UCase(Mid(Words[j],1, 1)) & Mid(Words[j],2, LEN(Words[j])-1);
		}
	}
	
	outputString = ArrayToList(Words, " ");

	return outputString;

}
</cfscript>


<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
</cfcomponent>