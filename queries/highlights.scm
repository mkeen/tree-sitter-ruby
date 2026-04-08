;; --- Identifiers & Variables ---
(identifier) @variable

((identifier) @function.method
 (#is-not? local))

[
  (class_variable)
  (instance_variable)
] @property

;; FIXED: Global variables with proper nesting and simplified regex escaping
((global_variable) @variable.builtin
 (#match? @variable.builtin "^\\$(-[ailp]|DEBUG|FILENAME|LOAD_PATH|LOADED_FEATURES|VERBOSE|stderr|stdin|stdout|[!$&'*+,./@\\_`~])$"))

(global_variable) @variable.other

[
  (self)
  (super)
] @variable.builtin

;; --- Keywords ---
[
  "alias"
  "and"
  "begin"
  "break"
  "case"
  "class"
  "def"
  "do"
  "else"
  "elsif"
  "end"
  "ensure"
  "for"
  "if"
  "in"
  "module"
  "next"
  "or"
  "rescue"
  "retry"
  "return"
  "then"
  "unless"
  "until"
  "when"
  "while"
  "yield"
] @keyword

((identifier) @keyword
 (#match? @keyword "^(private|protected|public)$"))

;; --- Constants ---
(constant) @constructor

((identifier) @constant.builtin
 (#match? @constant.builtin "^__(FILE|LINE|ENCODING)__$"))

(file) @constant.builtin
(line) @constant.builtin
(encoding) @constant.builtin

(hash_splat_nil
  "**" @operator) @constant.builtin

((constant) @constant
 (#match? @constant "^[A-Z\\d_]+$"))

;; --- Functions & Methods ---
"defined?" @function.method.builtin

(call
  method: [(identifier) (constant)] @function.method)

((identifier) @function.method.builtin
 (#eq? @function.method.builtin "require"))

(alias (identifier) @function.method)
(setter (identifier) @function.method)
(method name: [(identifier) (constant)] @function.method)
(singleton_method name: [(identifier) (constant)] @function.method)

;; --- Parameters ---
[
  (block_parameter (identifier))
  (block_parameters (identifier))
  (destructured_parameter (identifier))
  (hash_splat_parameter (identifier))
  (lambda_parameters (identifier))
  (method_parameters (identifier))
  (splat_parameter (identifier))
  (keyword_parameter name: (identifier))
  (optional_parameter name: (identifier))
] @variable.parameter

;; --- Literals ---
[
  (string)
  (bare_string)
  (subshell)
  (heredoc_body)
  (heredoc_beginning)
] @string

;; FIXED: Properly nested symbol and character predicates
((simple_symbol) @string.special.symbol
 (#match? @string.special.symbol "^:"))

((character) @string.special.symbol
 (#match? @string.special.symbol "^\\?"))

[
  (delimited_symbol)
  (hash_key_symbol)
  (bare_symbol)
] @string.special.symbol

(regex) @string.special.regex
(escape_sequence) @escape

[
  (integer)
  (float)
] @number

[
  (nil)
  (true)
  (false)
] @constant.builtin

(interpolation
  "#{" @punctuation.special
  "}" @punctuation.special) @embedded

(comment) @comment

;; --- Operators & Punctuation ---
[
  "="
  "=>"
  "->"
  "!"
  "?"
  "+"
  "-"
  "*"
  "/"
  "%"
  "**"
  "=="
  "!="
  ">"
  "<"
  ">="
  "<="
  "&&"
  "||"
] @operator

[
  ","
  ";"
  "."
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "%w("
  "%i("
] @punctuation.bracket
