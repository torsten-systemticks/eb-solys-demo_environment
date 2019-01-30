

import api.ScriptBase
import com.elektrobit.ebsolys.script.external.ScriptContext
import com.elektrobit.ebsolys.script.external.Execute
import com.elektrobit.ebsolys.script.external.Execute.ExecutionContext


class MusicplayerClient
{

	extension ScriptContext _scriptContext
    extension ScriptBase _scriptBase
    
     
    new (ScriptContext scriptContext) {
    	_scriptContext = scriptContext
        _scriptBase = new ScriptBase(_scriptContext)
    }

	
    /**
	 * Add a meaningful content to the description tag to describe the feature, which is executed by this script
	 * The content of the description tag will be used in all UI widgets where the script can be invoked
	 * If the content is empty, then the classname.methodname will be used instead
	 */
    /**
	 * Add a meaningful content to the description tag to describe the feature, which is executed by this script
	 * The content of the description tag will be used in all UI widgets where the script can be invoked
	 * If the content is empty, then the classname.methodname will be used instead
	 */
    @Execute(context=ExecutionContext.GLOBAL, description="Create a Musicplayer Client within EB solys GUI")
	def execute() {
    	// Your script code
    	createOrGetHtmlView("MusicplayerClient").content = 
    	'''
		<!DOCTYPE html>
		<html>
		<body>
		
		<iframe style="position: absolute; height: 100%; width: 100%; border: none" src="http:localhost:8180">
		  <p>Your browser does not support iframes.</p>
		</iframe>
		
		</body>
		</html>
		'''    	
	}


}



