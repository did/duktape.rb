$LOAD_PATH << 'lib' << 'ext/duktape'
require 'duktape'

# Create a new context
ctx = Duktape::Context.new

## Evaluate a string
p ctx.eval_string('1 + 1', 'hello.js')  # => 2

## Safely evaluate a string
ctx.eval_string <<EOF, 'boot.js'
function runSafely(fn) {
  try {
    fn()
  } catch (err) {
    print(err.stack || err);
  }
}
EOF

ctx.wrapped_eval_string('runSafely', <<EOF, 'oops.js')
function failDeeply() {
  (function() {
    throw new Error("fail");
  })();
}

failDeeply();
EOF

