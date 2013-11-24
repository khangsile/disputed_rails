object @answer
attributes :id, :name
node(:count) do |a|
	a.votes.count
end