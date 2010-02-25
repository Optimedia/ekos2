package br.com.optimedia.autor.view.components {
	
	import mx.formatters.DateFormatter;
	
	public class MySQLDateFormatter {
		
		public function MySQLDateFormatter() {
			
		}
		
		/**
		 * Função para passar uma data vinda do MySQL para uma data formatada no ActionScript
		 * 
		 * @param String
		 * @return Date
		 */ 
		public function mysqlToAs(mySQLDate:String):Date {
			if(mySQLDate != '') {
				
				var dateArray:Array;
				
				if(mySQLDate.lastIndexOf('T') != -1){
					dateArray = mySQLDate.split('T');
				} else {
					dateArray = mySQLDate.split(' ');
				}
				
				// Separando a data e hora
				var datePieces:Array = dateArray[0].split('-');
				var time:String = dateArray[1];
			
				// Verifica se há tempo.
				if(dateArray.length > 1) {
					
					if(dateArray[1].lastIndexOf('Z')!=-1){
						time = dateArray[1].slice(0, dateArray[1].lastIndexOf('Z', 0));
					}
					
					// Separando Hora, minuto, segundo (...)
					var timePieces:Array;
					var timeWithTimeZone:Array;
					var timeZone:Array;
					
					if(time.indexOf('-') != -1) {
						timeWithTimeZone = time.split('-');
						timePieces = timeWithTimeZone[0].split(':');
						timeZone = timeWithTimeZone[1].split(':');
					} else {
						timePieces = time.split(':');
					}
				}
				
				// Montando a classe Date no ActionScript
				if(timePieces) {
					// Se tiver tempo na data do mysql.
					
					var actionScriptDate:Date = new Date(datePieces[0], datePieces[1]-1, datePieces[2], timePieces[0], timePieces[1], timePieces[2]);
					return actionScriptDate;
				} else {
					// Se só tiver a data.
					
					var actionScriptDateNoTime:Date = new Date(datePieces[0], datePieces[1]-1, datePieces[2]);
					return actionScriptDateNoTime;
				}
			} else {
				return '' as Date;
			}
		
		}
		
		/**
		 * Função para passar uma data do ActionScript para o MySQL
		 * 
		 * @param Date
		 * @return String
		 */
		public function formatToMySQL(actionScriptDate:Date):String{
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = 'YYYY-MM-DD J:NN:SS';
			
			//Format Actionscript Date into simple String to add to MySQL Database
			return dateFormatter.format(actionScriptDate);
		}


	}
}