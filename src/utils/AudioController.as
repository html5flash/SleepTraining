package utils
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	/**
	 * Audio playback controller for the application, it works as a singleton object and provides API for audio playback
	 * controls with simple interfaces 
	 * 
	 * @aurthor		Gopal Sing (singh_gopal1981@yahoo.com)
	 * @version		1.0
	 * */
	public class AudioController
	{
		//--------------------------------------------------------------------------
		//
		//  PRIVATE PROPERTIES
		//
		//--------------------------------------------------------------------------
		
		private static var _instance:AudioController = null;
		
		private var _tempRandomInt:int;
		private var _sc:SoundChannel;
		private var _st:SoundTransform;
		private var _soundURLRequest:URLRequest;
		private var _soundContextLoader:SoundLoaderContext;
		private var _soundRequest:String;
		private var _genericSound:Sound;
		private var _sound:Sound;
		private var _audioClips:Array;
		private var _currentAudioClipIndex:Number;
		private var _callbackFunction:Function;
		private var _playBackTimer:Timer;
		private var _playBackDelay:Number;
		private var _isAudioPlaying:Boolean;
		
		
		//--------------------------------------------------------------------------
		//
		//  CONSTRUCTOR
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor method. Does not allow duplicate instances to be created from other layers with the help of SingletonEnforcer.
		 * @param	singletonEnforcer	SingletonEnforcer class object to prevent object instantiation from outside
		 * */
		public function AudioController( singletonEnforcer:SingletonEnforcer )
		{
			_playBackTimer = new Timer(1000, 1);
			_playBackDelay = -1;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC METHOD
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Returns the singleton instance of ApplicationNavigator
		 * @param	none
		 * @return	instance of ApplicationNavigator
		 * */
		public static function getInstance():AudioController
		{
			if( _instance == null )
			{
				_instance = new AudioController( new SingletonEnforcer() );
			}
			return _instance;
		}
		
		/**
		 * This method initiates the thread for playing back the array of audioClips one after another, possibly 
		 * with a playBackDelay b/w the audio clips' playback. 
		 * 
		 * This method is called from the activities when ever introuction instruction, feedback, background sound, etc
		 * audio has to be played or all of the audio needs to be stopped.
		 * 
		 * @param	audioClips			array of audio clips to play
		 * @param	callbackFunction	this call back function is called after completion of each audio playback
		 * @param	playBackDelay		delay amount b/w the audio clips' playback. Valus is in microseconds.
		 * 
		 * */
		public function playAudioClips( audioClips:Array, callbackFunction:Function = null, playBackDelay:Number = -1 ):void
		{
			stopAllSound();
			
			_callbackFunction = callbackFunction;
			_playBackDelay = playBackDelay;
			
			_sc = new SoundChannel();
			_audioClips = [];
			for(var m:Number = 0; m < audioClips.length; m++)
			{
				_audioClips.push(audioClips[m])
			}
			
			_currentAudioClipIndex = 0;	
			_isAudioPlaying = true;
			playAudio(_audioClips[_currentAudioClipIndex]);
		}
		
		
		/**
		 * Plays the sound object with the help of ChannelMixer
		 * @param	sound	instance of Sound
		 * @return	void
		 * */
		public function playAudio( sound:Sound ):void
		{
			if(sound && _isAudioPlaying == true)
			{	
				_sc.stop();				
				_sc = sound.play();				
				_sc.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			}
			else
			{
				if(_callbackFunction != null)
					_callbackFunction.call(null,_currentAudioClipIndex, _audioClips.length);
				
				_currentAudioClipIndex++;
				
				if(_currentAudioClipIndex < _audioClips.length)
					playAudio(_audioClips[_currentAudioClipIndex]);
			}
		}	
		
		/**
		 * Stops the playback of current and pending audio clips and also stops the playback timer
		 * @param	none
		 * @return	void
		 * */
		public function stopAllSound():void
		{
			SoundMixer.stopAll();
			_playBackTimer.stop();
			_playBackTimer.reset();
			_playBackTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onPlaybackDelayOver);
			
			_isAudioPlaying = false;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE METHOD
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Event handler method for the active audio clip Event.SOUND_COMPLETE event.
		 * On the audio playback complete event, it gives control to the activity template by calling it's callbackFuncion. Activity template
		 * uses the callback to do things like text highligh/unhighligh.
		 * 
		 * After the callback function, playback of the next audio gets started.
		 * 
		 * @param	event	instance of Event
		 * @return	void
		 * */
		private function soundCompleteHandler(event:Event):void
		{
			if(_isAudioPlaying == true)
			{
				if(_callbackFunction != null)
					_callbackFunction.call(null,_currentAudioClipIndex, _audioClips.length);
				
				_sc.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
				if(_audioClips.length > 1)
				{
					_currentAudioClipIndex++;
					if(_playBackDelay == -1)
					{
						playAudio(_audioClips[_currentAudioClipIndex]);					
					}
					else
					{
						_playBackTimer.delay = _playBackDelay;
						_playBackTimer.repeatCount = 1;
						_playBackTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onPlaybackDelayOver);
						
						_playBackTimer.start();
					}
				}
			}
		}
		
		/**
		 * Complete event handler for the audio clip playback timer object. It starts playback of the next audio clips.
		 * 
		 * @param	event	instance of the Event class
		 * @return	void
		 * */
		private function onPlaybackDelayOver(event:Event):void
		{
			_playBackTimer.stop();
			_playBackTimer.reset();
			_playBackTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onPlaybackDelayOver);	
			
			playAudio(_audioClips[_currentAudioClipIndex]);
		}
	}
}

class SingletonEnforcer{}