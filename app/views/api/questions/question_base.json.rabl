object @question, object_root: false
attributes :id, :content, :votes_count
node(:map) { |q| q.map_display }
child(:answers, object_root: false) do
	extends('api/answers/answer')
end
