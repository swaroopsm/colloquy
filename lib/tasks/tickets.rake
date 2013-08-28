namespace :tickets do
	desc "Clear duplicate tickets from Conference Users"
	task :clear => :environment do
		c = ConferenceUser.all
		d = c.group_by{ |i| i[:ticket]  } # Groups by the ticket number
		d.each do |i|
			if i[1].size > 1
				p "Size is #{i[1].size}"
				p "-------"
		     p "Deleting..."
		     1.upto(i[1].size-1) do |pp| # Loops from the second array index onwards..
			   		i[1][pp].destroy
			 	 end
			end
		end
	end
end
