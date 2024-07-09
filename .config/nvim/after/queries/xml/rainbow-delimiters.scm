(XMLDecl "<?" @delimiter "?>" @delimiter @sentinel) @container
(element 
  ((STag
     "<" @delimiter ">" @delimiter)
   ; (content)
   (ETag
     "</" @delimiter ">" @delimiter @sentinel))) @container

(element
  (EmptyElemTag
    "<" @delimiter "/>" @delimiter @sentinel)) @container
