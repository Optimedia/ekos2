package br.com.optimedia.atendimento.remote
	
	public final class MySingleton {
		
		private static var instance:Singleton = new Singleton();
				
		public function MySingleton() {
			if( instance ) Alert.show("Erro, use Singleton.getInstance() em vez de new Singleton()");
			
		}
		public static function getInstance():Singleton {
			return instance;
			
		}
	}
}