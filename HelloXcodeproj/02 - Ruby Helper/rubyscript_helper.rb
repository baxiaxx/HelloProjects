# This file provide convenient methods
#
# Usage:
#   require_relative '../02 - Ruby Helper/rubyscript_helper'
#
# References:
#   https://stackoverflow.com/questions/16856243/how-to-require-a-ruby-file-from-another-directory



# 1. Dump object
#
# Demo output:
# [Debug] test_dump_object.rb:8: string = (String) "hello, world"
# [Debug] test_dump_object.rb:9: dict = (Hash) {}
# [Debug] test_dump_object.rb:10: array = (Array) []
# [Debug] test_dump_object.rb:11: number = (Integer) 3
# [Debug] test_dump_object.rb:13: "string" = (String) "string"
# [Debug] test_dump_object.rb:14: {} = (Hash) {}
# [Debug] test_dump_object.rb:15: [1, 2, 3] = (Array) [1, 2, 3]
# [Debug] test_dump_object.rb:16: 3.14 = (Float) 3.14
#
# @see https://stackoverflow.com/questions/15769739/determining-type-of-an-object-in-ruby
# @see https://stackoverflow.com/questions/41032717/get-original-variable-name-from-function-in-ruby
# @see https://stackoverflow.com/questions/3453262/how-to-strip-leading-and-trailing-quote-from-string-in-ruby
def dump_object(arg)
  loc = caller_locations.first
  line = File.read(loc.path).lines[loc.lineno - 1]

  # get string started by `dump_object`
  callerString = line[/#{__method__}\(.*?\)/].to_s

  # get parameter name of `dump_object`
  argName = callerString[/\(.*?\)/]
  # get content of parenthesis
  argNameStr = argName.gsub!(/^\(|\)?$/, '')

  filename = loc.path
  lineNo = loc.lineno

  puts "[Debug] #{filename}:#{lineNo}: #{argNameStr} = (#{arg.class}) #{arg.inspect}"
end
