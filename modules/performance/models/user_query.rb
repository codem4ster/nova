class Performance::Models::UserQuery < Neo::Database::ModelQuery
	def with_name(name)
		self.add_where([%w[name = {name}]]).add_parameters name: name
	end

	def with_names(names)
		self.add_where([%w[name IN {names}]]).add_parameters names: names
	end

	def friends
		self.add_match('friends','PerfUser',{}, '<-[r:HasFriend]-n')
	end

	def event_names
		self.add_match('events', 'Event', {}, '<-[e:Joins]-friends')
	end
end