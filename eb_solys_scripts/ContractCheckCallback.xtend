import api.ScriptBase
import com.elektrobit.ebsolys.core.targetdata.api.decoder.DecodedRuntimeEvent
import com.elektrobit.ebsolys.core.targetdata.api.runtime.eventhandling.RuntimeEvent
import com.elektrobit.ebsolys.core.targetdata.api.runtime.eventhandling.RuntimeEventChannel
import com.elektrobit.ebsolys.core.targetdata.api.runtime.eventhandling.RuntimeEventTag
import com.elektrobit.ebsolys.core.targetdata.api.runtime.eventhandling.Unit
import com.elektrobit.ebsolys.script.external.BeforeScript
import com.elektrobit.ebsolys.script.external.Execute
import com.elektrobit.ebsolys.script.external.Execute.ExecutionContext
import com.elektrobit.ebsolys.script.external.ScriptContext
import java.io.File
import java.util.List
import com.elektrobit.ebsolys.script.external.AfterScript

class ContractCheckCallback
{

	extension ScriptContext _scriptContext
    extension ScriptBase _scriptBase
	
	RuntimeEventChannel<String> ch    
	val REMOTE_CONNECTION = "VirtualBox"
     
    new (ScriptContext scriptContext) {
    	_scriptContext = scriptContext
        _scriptBase = new ScriptBase(_scriptContext)
    }

	@BeforeScript
	def setup() {
				
		val con = createOrGetConnection(REMOTE_CONNECTION, "192.168.2.4", 1234, true)
		con?.connectToTarget
		
		Thread.sleep(2000)
		
		ch = createOrGetChannel("contracts.Musicplayer", Unit.TEXT, "")
		val initTS = getChannel(REMOTE_CONNECTION+'.cpu.system').events.last.timestamp
		doStateChange(initTS, "Idle")		
	}
		
	/**
	 * Add a meaningful content to the description tag to describe the feature, which is executed by this script
	 * The content of the description tag will be used in all UI widgets where the script can be invoked
	 * If the content is empty, then the classname.methodname will be used instead
	 */
    @Execute(context=ExecutionContext.CALLBACK, description="Run Franca Contract Checker for Musicplayer Example")
	def execute(List<RuntimeEvent<?>> events) {
    	events.filter[channelName.equals('ipc.wamp.musicplayer')].forEach[
    		decode.checkIsValidCall
    	]
	}

	// DO NOT EDIT - GENERATED CODE
	def createIdle()
	{
		'''
		{
			"current" : "Idle",
			"transitions" : [
				{ "type" : "request", "message" : "findTrackByTitle", "to" : "SearchingTrack" }
			]
		}
		'''
	}

	def createSearchingTrack()
	{
		'''
		{
			"current" : "SearchingTrack",
			"transitions" : [
				{ "type" : "response", "message" : "findTrackByTitle", "to" : "TrackSelected" },
				{ "type" : "error", "message" : "findTrackByTitle", "to" : "Idle" }
			]
		}
		'''		
	}

	def createTrackSelected()
	{
		'''
		{
			"current" : "TrackSelected",
			"transitions" : [
				{ "type" : "request", "message" : "play", "to" : "RequestedPlaying" },
				{ "type" : "request", "message" : "findTrackByTitle", "to" : "SearchingTrack" }
			]
		}
		'''		
	}

	def createRequestedPlaying()
	{
		'''
		{
			"current" : "RequestedPlaying",
			"transitions" : [
				{ "type" : "response", "message" : "play", "to" : "Playing" }
			]
		}
		'''		
	}

	def createPlaying()
	{
		'''
		{
			"current" : "Playing",
			"transitions" : [
				{ "type" : "request", "message" : "pause", "to" : "RequestedPause" },
				{ "type" : "request", "message" : "findTrackByTitle", "to" : "SearchingTrack" }
			]
		}
		'''		
	}

	def createRequestedPause()
	{
		'''
		{
			"current" : "RequestedPause",
			"transitions" : [
				{ "type" : "response", "message" : "pause", "to" : "TrackSelected" }
			]
		}
		'''		
	}

	def createChangeState(String newState)
	{
		switch (newState)
		{
			case 'Idle' : createIdle()			
			case 'SearchingTrack' : createSearchingTrack()			
			case 'TrackSelected' : createTrackSelected()			
			case 'RequestedPlaying' : createRequestedPlaying()			
			case 'Playing' : createPlaying()			
			case 'RequestedPause' : createRequestedPause()			
		}
	}

	def checkIsValidCall(DecodedRuntimeEvent trace)
	{
		val traceMsgType = trace.getFirstNode('edge').getFirstValue('type')
		
		if(traceMsgType.equals("broadcast")) return
		
		val currentState = ch.events.sortBy[timestamp].last.decode
					
		val matches = currentState.getFirstNode('transitions').children.filter[
			getFirstValue('type').equals(traceMsgType) && getFirstValue('message').equals(trace.getFirstValue('method'))
		]
								
		switch (matches.size)
		{
			case 0: trace.runtimeEvent.setTag(RuntimeEventTag.ERROR, "Expected messages: "+currentState.getFirstNode('transitions').children.map[getFirstValue('message')] )				
			case 1: doStateChange( trace.runtimeEvent.timestamp, matches.head.getFirstValue('to'))
			default : trace.runtimeEvent.setTag(RuntimeEventTag.ERROR, "Should not happen")
		}
		
	}
	
	def doStateChange(long timestamp, String newState)
	{		
		val jsonEvent = '''
		{
			"uptime" : «timestamp»,
			"channel" : contracts.Musicplayer,
			"value" : {
				"summary" : «newState»,
				"details" : «createChangeState(newState)»
			}
		}
		'''.toString
				
		addJsonEvent(jsonEvent)
		
		showPlantUmlInHtmlViewLocal(stateMachine(newState).toString, "musicplayer")
		
		callJavaScriptFunction( getHtmlView("musicplayer"), "reloadImg", "")
	}

	def stateMachine(String highlightedState)
	{
		'''
		@startuml
		skinparam monochrome true

		state «highlightedState» #YellowGreen
		
		[*] -> Idle
		Idle --> SearchingTrack : "call findTrackByTitle"
		SearchingTrack --> Idle : "error findTrackByTitle"
		SearchingTrack --> TrackSelected : "respond findTrackByTitle"
		TrackSelected --> RequestedPlaying : "call play"
		TrackSelected --> SearchingTrack : "call findTrackByTitle"
		RequestedPlaying --> Playing : "respond play"
		Playing --> RequestedPause : "call pause"
		Playing --> SearchingTrack : "call findTrackByTitle"
		RequestedPause --> TrackSelected : "respond pause"
		@enduml
		'''
	}
	
	def showPlantUmlInHtmlViewLocal(String plantUmlText, String htmlViewName) {
				
		var pathToPNG = htmlViewName.toLowerCase
		pathToPNG = pathToPNG.replaceAll("\\s","")
		pathToPNG += "-plantuml.png"
		
		new File(pathToPNG).deleteOnExit()
		
		plantUmlText.plantUmlToPNG(pathToPNG)		
		
		val htmlView = createOrGetHtmlView(htmlViewName)
		htmlView.content = 
		'''
		<html>
		<head>
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
			<script type="text/javascript">
				function reloadImg() {
					d = new Date();
					$("#stateMachineImageId").attr("src", "musicplayer-plantuml.png?"+d.getTime());		
				}
			</script>
		</head>
		<body>
			<img id="stateMachineImageId" />
			<!--
			<input type="button" value="Reload Image" onclick="reloadImg()" />
			-->
		</body>
		</html>		
		'''
	}
	
}



