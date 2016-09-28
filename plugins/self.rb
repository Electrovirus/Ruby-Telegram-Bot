
#Encoding: UTF-8

 if @config["Devlopers"].include?(message.from.id)
	case message.text
	when "/add"
		@config["Groups"].insert(0,message.chat.id)
		bot.api.send_message(chat_id: message.chat.id, text: "Bot activated 🔋" )
	when "/prom"
		@config["Admins"].insert(0,message.reply_to_message.from.id)
		bot.api.send_message(chat_id: message.chat.id, text: "#{message.reply_to_message.from.first_name} #{message.reply_to_message.from.last_name} has been promoted" )
	when "/rem"
		bot.api.send_message(chat_id: message.chat.id, text: "#{message.reply_to_message.from.first_name} #{message.reply_to_message.from.last_name} has been disqualified" )
	end
 end
  s_tofiko = "Please do not send stickers🐼❎"
 h_tofiko = "Please do not send links🐼❎"
  v_tofiko = "Please do not send videos🐼❎"
  w_tofiko =  "Hi welcome🐼☑" 
if @config["Admins"].include?(message.from.id)
	
	if message.text == "/id" 
		bot.api.send_message(chat_id: message.chat.id, text: message.chat.id, reply_to_message: message.message_id)
	elsif message.text == "/bban" && message.reply_to_message && !@config["Devlopers"].include?(message.reply_to_message.from.id)
		bd[message.reply_to_message.from.id] = message.reply_to_message.from.id
		bot.api.send_message(chat_id: message.chat.id, text: "#{message.reply_to_message.from.username} has been permanently blocked from the bot" )
	elsif message.text == "/ban" && message.reply_to_message && !@config["Devlopers"].include?(message.reply_to_message.from.id)
		@config["bban"].insert(0,message.reply_to_message.from.id)
		bot.api.send_message(chat_id: message.chat.id, text: "#{message.reply_to_message.from.username} has been blocked from the bot" )
	elsif message.text == "/unban" && message.reply_to_message && !@config["Devlopers"].include?(message.reply_to_message.from.id)
		@config["bban"].delete(message.reply_to_message.from.id)
		bot.api.send_message(chat_id: message.chat.id, text: "#{message.reply_to_message.from.username} has been unblocked" )
	end
end
if  !bd[message.from.id] && !@config["bban"].include?(message.from.id)
if message.text.to_s.include?"http" 
    bot.api.send_message(chat_id: message.chat.id, text: h_tofiko)
end
if  message.text == "/kick" && message.reply_to_message && @config["Admins"].include?(message.from.id)
    bot.api.kickChatMember(chat_id: message.chat.id, user_id: message.reply_to_message.from.id)
    bot.api.send_message(chat_id: message.chat.id, text: "Kicked from the group🔴" )
end

case message.text

  when "/start"
if db[message.from.id]
      bot.api.send_message(chat_id: message.chat.id, text: " Hi welcome to my ruby bot🌎\nBot started🔊" )
    else
			db[message.from.id] = {
				"username"=>message.from.username,
}
							bot.api.send_message(chat_id: message.chat.id, text: "Created by @Electrovirus" )
			puts "#{message.from.username}".on_green
end
	when "/me"
    if db[message.from.id]
      bot.api.send_message(chat_id: message.chat.id, text: 	"Username: @#{message.from.username} \n Id: #{message.from.id} ")
    end
if message.new_chat_member
   bot.api.send_message(chat_id: message.chat.id, text: w_tofiko)
end
  if message.video
	bot.api.send_message(chat_id: message.chat.id, text: v_tofiko)
  end
    if message.sticker
	bot.api.send_message(chat_id: message.chat.id, text: s_tofiko ) 
  end
    if message.text.to_s.include?("http")
    bot.api.kickChatMember(chat_id: message.chat.id, user_id: message.from.id)
    bot.api.send_message(chat_id: message.chat.id, text: "Kicked from the group🔴" )
    end
    if message.text == "/stop" && db[message.from.id] && message.reply_to_message && db[message.reply_to_message.from.id]
    	bot.api.send_message(chat_id: message.chat.id, text : "Bot has been stopped🔇")
if message.text == "/he" && db[message.from.id] && message.reply_to_message && db[message.reply_to_message.from.id]
		bot.api.send_message(chat_id: message.chat.id, text: "Username: @#{message.reply_to_message.from.username} \n Firstname: #{message.reply_to_message.from.first_name} \nLastname: #{message.reply_to_message.from.last_name}\n ")
end
end 
end

