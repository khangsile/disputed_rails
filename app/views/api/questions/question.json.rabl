object @question
attributes :content
child(:answers) do
	attributes :id, :name
end