object @question
attributes :id, :content
child(:answers, object_root: false) do
	extends('api/answers/answer')
end
node(:answered) { true }