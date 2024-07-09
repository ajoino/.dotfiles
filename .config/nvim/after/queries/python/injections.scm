(call
  function: ((identifier) @_name)
  arguments: (argument_list
             (string 
               (string_content) @injection.content
           (#set! injection.include-children)
           (#set! injection.language "ebnf")
           (#eq? @_name "Grammar")
           )))
