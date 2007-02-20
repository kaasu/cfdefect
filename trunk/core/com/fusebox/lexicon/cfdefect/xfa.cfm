<cfscript>
	fb_.fbApp = fb_.verbInfo.action.getCircuit().getApplication();
	if (fb_.verbInfo.executionMode is "start") {
		// validate attributes
		// name - string - required
		if (not structKeyExists(fb_.verbInfo.attributes,"name") or trim(fb_.verbInfo.attributes.name) is "") {
			fb_throw("fusebox.badGrammar.requiredAttributeMissing",
						"Required attribute is missing",
						"The attribute 'name' is required,for a 'xfa' verb in fuseaction #fb_.verbInfo.circuit#.#fb_.verbInfo.fuseaction#.");
		}
		// value - string - required
		if (not structKeyExists(fb_.verbInfo.attributes,"value")) {
			fb_throw("fusebox.badGrammar.requiredAttributeMissing",
						"Required attribute is missing",
						"The attribute 'value' is required, for a 'xfa' verb in fuseaction #fb_.verbInfo.circuit#.#fb_.verbInfo.fuseaction#.");
		}
		// if there are children, set up a parameter block:
		//if (fb_.verbInfo.hasChildren) {
			// do not allow URL parameters in the XFA value:
		//	if (find(fb_.fbApp.queryStringSeparator,fb_.verbInfo.attributes.value) neq 0) {
		//		fb_throw("fusebox.badGrammar.invalidAttributeValue",
		//					"Attribute has invalid value",
		//					"The attribute 'value' contains URL parameters, which is not allowed when 'parameter' is present, for a 'xfa' verb in fuseaction #fb_.verbInfo.circuit#.#fb_.verbInfo.fuseaction#.");
		//	}
			// this is where the child <parameter> verbs will store the parameter details:
		//	fb_.verbInfo.parameters = arrayNew(1);
		//}
		
	} else {	
		// compile <xfa>
		name = "xfa." & fb_.verbInfo.attributes.name;
		value = fb_.verbInfo.attributes.value;
		
		if ( ListLen( value, '.' ) LT 2){
			// adjust xfa value if it is local to this circuit:
			// <xfa name="foo" value="bar" /> becomes
			// <xfa name="foo" value="thiscircuit.bar" />
			value = fb_.verbInfo.circuit & '.'& value;
		}
		
		// append any parameters to the URL value:
		//if (fb_.verbInfo.hasChildren) {
		//	fb_.n = arrayLen(fb_.verbInfo.parameters);
		//	for (fb_.i = 1; fb_.i lte fb_.n; fb_.i = fb_.i + 1) {
		//		value = value & fb_.fbApp.queryStringSeparator & fb_.verbInfo.parameters[fb_.i].name &
		//						fb_.fbApp.queryStringEqual & fb_.verbInfo.parameters[fb_.i].value;
		//	}
		//}
		value = '"' & value & '"';
		
		//if (find("##",name) gt 0) {
		//	name = '"' & name & '"';
		//}
		fb_appendLine("<cfset event.setValue( '#name#', '#value#' ) />");
	}
</cfscript>

