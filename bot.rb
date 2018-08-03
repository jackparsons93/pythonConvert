
require 'yandex-translator'
require 'socket'
translator = Yandex::Translator.new('trnsl.1.1.20180731T232407Z.2d3b500877260736.d6a4b1322b8071c460e3c3b8eab22c210dcc6c06')
#puts (translator.translate 'ブラブラブラ', from: 'en')

#line_as_string="meowko :カナダ何年住んでらっしゃるんですか？"
#x=line_as_string.split("meowko")[-1]
#puts x
#puts (translator.detect("meowko :カナダ何年住んでらっしゃるんですか？"))

TWITCH_HOST="irc.twitch.tv"
TWITCH_PORT=6667	

class TwitchBot

	def initialize
		@translator=Yandex::Translator.new('trnsl.1.1.20180731T232407Z.2d3b500877260736.d6a4b1322b8071c460e3c3b8eab22c210dcc6c06')
		@nickname="heyzeushealsbot"
		@password="oauth:nsbeh62wf2y3jssajl1gfxfto4hule"
		@channel="meowko"
		@socket=TCPSocket.open(TWITCH_HOST, TWITCH_PORT)

		write_to_system  "PASS #{@password}"
		write_to_system	 "NICK #{@nickname}"
		write_to_system	 "USER #{@nickname} 0 * #{@nickname} "
		write_to_system  "JOIN ##{@channel}"
	end

	def write_to_system(message)
		@socket.puts message
	end

	def write_to_chat(message)
		write_to_system "PRIVMSG ##{@channel} :#{message}"
	end
 
	def run 
		until @socket.eof? do
			message=@socket.gets
			puts message
			line_as_string=message
			split_message=line_as_string.split("meowko :")[-1]
			puts split_message
			if @translator.detect(split_message)=='ja'
				write_to_chat(@translator.translate(split_message , from: 'en'))
			end
			
		end
	end

end

