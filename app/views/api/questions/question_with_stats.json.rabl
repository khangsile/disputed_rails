object @question
extends('api/questions/question')
child(:answers, object_root: false) do
	extends('api/answers/answer')
end
node(:answered) { true }