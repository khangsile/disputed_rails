object @question
attributes :id, :content, :votes_count, :map_display
child(:answers, object_root: false) do
	attributes :id, :name
end
node(:answered) { false }