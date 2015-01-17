require 'benchmark'

class Performance::Commands::TestMass < Main::Commands::BaseCommand
	UserModel = Performance::Models::User
	UserQuery = Performance::Models::UserQuery
	EventModel = Performance::Models::Event
	Cypher = Neo::Database::Cypher
	Transaction = Neo::Database::Transaction

	def run

		# events =  []
		# 8.times.with_index do |i|
		# 	event = EventModel.new
		# 	event.name = "Event Name #{i}"
		# 	event.date = Time.now.to_i + rand(1000..99999)
		# 	event.save
		# 	events << event
		# end
		#
		# users = []
		# 4000.times.with_index do |i|
		# 	user = UserModel.new
		# 	user.name = "İsim#{i}"
		# 	user.age = rand(16..32)
		# 	user.profile_info = "Profile#{i}"
		# 	user.save
		# 	event = events.sample
		# 	user.relate_to event, 'Joins'
		# 	if users.length > 4
		# 		friends = users.sample(rand(2..30))
		# 		friends.each do |friend|
		# 			user.relate_to friend, 'HasFriend'
		# 		end
		# 	end
		# 	users << user
		# end


		Benchmark.bm(7, '>avg:') do |x|
			results = []
			tot = Benchmark::Tms.new
			10.times do
				tot += x.report(:friends) {
					results << UserQuery.new.with_name("İsim#{rand(1..4000)}")
						.friends.set_return('friends.name').get_all
				}
			end
			[tot/10]
		end

		Benchmark.bm(21, '>avg:') do |x|
			results = []
			tot = Benchmark::Tms.new
			10.times do
				tot += x.report(:friends_joined_events) {
					results << UserQuery.new.with_name("İsim#{rand(1..4000)}")
															.friends.event_names.set_return('events.name').get_all
				}
			end
			[tot/10]
		end


		# Benchmark.bm(31) do |x|
		# 	results = []
		# 	names = []
		# 	10.times do
		# 		names << "İsim#{rand(1..4000)}"
		# 	end
		# 	x.report(:ten_users_friends_joined_events) do
		# 		results << UserQuery.new.with_names(names)
		# 			.friends.event_names.set_return('events.name').get_all
		# 	end
		# end

		Benchmark.bm(31) do |x|
			names = []
			10.times do
				names << "İsim#{rand(1..4000)}"
			end
			x.report(:ten_users_friends_joined_events) do
				puts UserQuery.new.with_names(names).friends.set_return('friends.name').build.to_json
			end

		end

	end
end