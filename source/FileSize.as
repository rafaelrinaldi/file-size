package {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	*
	* Retrieve the total bytes of any file from the client-side.
	*
	* @see http://github.com/rafaelrinaldi/file-size
	*
	* @author Rafael Rinaldi (rafaelrinaldi.com)
	* @since Oct 16, 2012
	*
	**/
	
	public class FileSize extends MovieClip {
		
		/**
		* On file start loading.
		**/
		protected const START : String = "onStart";
		
		/**
		* On file complete its loading.
		**/
		protected const COMPLETE : String = "onComplete";
		
		/**
		* IO error or simply bad url.
		**/
		protected const ERROR : String = "onError";
		
		/**
		* When current loading is canceled.
		**/
		protected const CANCEL : String = "onCancel";

		/**
		* File path set by flashvars.
		**/
		protected const FILE : String = loaderInfo.parameters["file"] || loaderInfo.parameters["f"];

		/**
		* Actual loader.
		**/
		protected var loader : URLLoader;

		public function FileSize() {
			
			// If `ExternalInterface` isn't available, don't even start.
			if(!ExternalInterface.available) return;

			ExternalInterface.addCallback("get", get);
			ExternalInterface.addCallback("cancel", cancel);

			loader = new URLLoader;
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.addEventListener(ProgressEvent.PROGRESS, loaderProgressHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			
			// By default it starts loading the file set by flashvars.
			get(FILE);

		}
		
		/**
		*
		* Start loading a new file.
		* This method will only work if it's called as a direct result of a user action. Otherwise, the browser will block it.
		*
		* @param p_url URL of file to be loaded.
		*
		**/
		public function get( p_url : String ) : void {

			if(p_url == "" || p_url == null) {
				ExternalInterface.call(ERROR, "Invalid url. Nothing will be loaded.");
				return;
			}

			loader.load(new URLRequest(p_url));

			ExternalInterface.call(START, p_url);

		}
		
		/**
		*
		* Cancel current loading process.
		*
		**/
		public function cancel() : void
		{

			try {
				loader.close();
			} catch( error : Error ) {
				// None stream opened
			}

			ExternalInterface.call(CANCEL, loader.bytesLoaded);

		}

		/**
		*
		* Only loads enough information to retrieve the file size.
		* @private
		*
		**/
		protected function loaderProgressHandler( event : ProgressEvent ) : void
		{
			if(event.bytesTotal && event.bytesTotal > 0) {
				cancel();
				loaderCompleteHandler(null);
			}
		}
		
		/**
		*
		* Loader complete handler.
		* @private
		*
		**/
		protected function loaderCompleteHandler( event : Event ) : void
		{
			ExternalInterface.call(COMPLETE, loader.bytesTotal);
		}

		/**
		*
		* IO error handler.
		* @private
		*
		**/
		protected function loaderIOErrorHandler( event : IOErrorEvent ) : void
		{
			ExternalInterface.call(ERROR, event.text);
		}
		
	}
}