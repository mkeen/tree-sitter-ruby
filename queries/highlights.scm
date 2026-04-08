;; 1. Variables & Identifiers
(identifier) @variable

((identifier) @function.method
 (#is-not? local))

[
  (class_variable)
  (instance_variable)
] @property

;; Fix for the "Error at 32": Simplified Global Variable Match
((global_variable) @variable.builtin
 (#match? @variable.builtin "^\\$"))

[
  (self)
  (super)
] @variable.builtin

;; 2. Keywords
[
  "alias" "and" "begin" "break" "case" "class" "def" "do" "else" "elsif" 
  "end" "ensure" "for" "if" "in" "module" "next" "or" "rescue" "retry" 
  "return" "then" "unless" "until" "when" "while" "yield"
] @keyword

((identifier) @keyword
 (#match? @keyword "^(private|protected|public)$"))

;; 3. Constants
(constant) @constructor

((identifier) @constant.builtin
 (#match? @constant.builtin "^__(FILE|LINE|ENCODING)__$"))

((constant) @constant
 (#match? @constant "^[A-Z\\d_]+$"))

;; 4. Functions & Methods
"defined?" @function.method.builtin

(call
  method: [(identifier) (constant)] @function.method)

((identifier) @function.method.builtin
 (#eq? @function.method.builtin "require"))

(method name: [(identifier) (constant)] @function.method)
(singleton_method name: [(identifier) (constant)] @function.method)

;; 5. Parameters
[
  (block_parameter (identifier))
  (method_parameters (identifier))
  (keyword_parameter name: (identifier))
  (optional_parameter name: (identifier))
] @variable.parameter

;; 6. Literals (Fix for "Error at 65")
[
  (string)
  (bare_string)
  (heredoc_body)
  (heredoc_beginning)
] @string

(simple_symbol) @string.special.symbol
(regex) @string.special.regex

[
  (integer)
  (float)
  (nil)
  (true)
  (false)
] @constant.builtin

(interpolation
  "#{" @punctuation.special
  "}" @punctuation.special) @embedded

(comment) @comment

;; 7. Operators & Punctuation
["=" "=>" "->" "!" "?" "+" "-" "*" "/" "==" "!=" ">" "<" "&&" "||"] @operator
["," ";" "."] @punctuation.delimiter
["(" ")" "[" "]" "{" "}" ] @punctuation.bracket
