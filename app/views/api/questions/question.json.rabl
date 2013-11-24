object @question
attributes :content
child(:answers, object_root: false) do
	attributes :id, :name
end