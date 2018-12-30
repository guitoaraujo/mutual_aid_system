task :check_complete_cicles => :environment do
	cicles = Cicle.where(status: :active)
	cicles.each do |cicle|
		if cicle.complete_date >= Time.now
			if cicle.phase < 8
				cicle.hold!
			else
				cicle.finished!
			end
			user        = cicle.user
			user.wallet = user.wallet + (cicle.order.value * 1.6)
			user.save
		end
	end
end