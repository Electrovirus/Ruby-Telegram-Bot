#Encoding: UTF-8

 if @config["Devlopers"].include?(message.from.id)
	case message.text
	when "/add"
		@config["Groups"].insert(0,message.chat.id)
		bot.api.send_message(chat_id: message.chat.id, text: "تم التفعيل!" )
	when "/prom"
		@config["Admins"].insert(0,message.reply_to_message.from.id)
		bot.api.send_message(chat_id: message.chat.id, text: "#{message.reply_to_message.from.first_name} #{message.reply_to_message.from.last_name} has been promoted" )
	when "/rem"
		bot.api.send_message(chat_id: message.chat.id, text: "#{message.reply_to_message.from.first_name} #{message.reply_to_message.from.last_name} has been disqualified" )
	end
 end
if @config["Admins"].include?(message.from.id)
	
	if message.text == "/id" 
		bot.api.send_message(chat_id: message.chat.id, text: message.chat.id, reply_to_message: message.message_id)
	elsif message.text == "/ids" && message.reply_to_message
		bot.api.send_message(chat_id: message.chat.id, text: message.reply_to_message.from.id )
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
    bot.api.send_message(chat_id: message.chat.id, text:"عزيزي🐸🌸:  #{message.from.first_name} #{message.from.last_name}\n ممنوع ارسال الروابط❌") 
end
if  message.text == "!طرد" && message.reply_to_message && @config["Admins"].include?(message.from.id)
    bot.api.kickChatMember(chat_id: message.chat.id, user_id: message.reply_to_message.from.id)
    bot.api.send_message(chat_id: message.chat.id, text: "لقد تم الطرد من المجموعة!" )
end

case message.text

  when "/start"
if db[message.from.id]
      bot.api.send_message(chat_id: message.chat.id, text: " تابع @mtofee!" )
    else
			db[message.from.id] = {
				"username"=>message.from.username,
}
							bot.api.send_message(chat_id: message.chat.id, text: "تابع @mtofee  !" )
			puts "#{message.from.username}".on_green
end

	when "/me"
    if db[message.from.id]
      bot.api.send_message(chat_id: message.chat.id, text: "معرفك: @#{message.from.username} \nالأسم الاول:  #{message.from.first_name}\n الأسم الاخير: #{message.from.last_name} \n الأيدي الخاص بك: #{message.from.id} ") 
    end
if message.new_chat_member
   bot.api.send_message(chat_id: message.chat.id, text: "اهلا بك يا#{message.new_chat_member.first_name}!
   الاسم الثاني#{message.new_chat_member.last_name}
   ايديك #{message.new_chat_member.id}
   تابع @mtofee" )
end
  if message.video
	bot.api.send_message(chat_id: message.chat.id, text:"عزيزي🐸🌸:  #{message.from.first_name} #{message.from.last_name}\n ممنوع ارسال الوسائط هنا ستتعرض للطرد!❌") 
  end
    if message.sticker
	bot.api.send_message(chat_id: message.chat.id, text:"عزيزي🐸🌸:  #{message.from.first_name} #{message.from.last_name}\n ممنوع ارسال االملصقات هنا ستتعرض للطرد!❌") 
  end
    if message.text.to_s.include?("http")
    bot.api.kickChatMember(chat_id: message.chat.id, user_id: message.from.id)
    bot.api.send_message(chat_id: message.chat.id, text: "لقد تم الطرد من المجموعة!" )
    end
if message.text == "/he" && db[message.from.id] && message.reply_to_message && db[message.reply_to_message.from.id]
		bot.api.send_message(chat_id: message.chat.id, text: "معرفه: @#{message.reply_to_message.from.username} \n الاسم الاول: #{message.reply_to_message.from.first_name} \nالاسم الاخير: #{message.reply_to_message.from.last_name}\n ")
end
end 