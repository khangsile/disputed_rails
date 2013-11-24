object @question
attributes :id, :content, :votes_count
child(:answers, object_root: false) do
	attributes :id, :name
end
node(:answered) { false }