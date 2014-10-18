require 'mkmf'

RbConfig::MAKEFILE_CONFIG['CC'] = ENV['CC'] if ENV['CC']

$CFLAGS << " #{ENV["CFLAGS"]}"

if RUBY_VERSION >= '1.9.3'
  $CFLAGS << ' -DHAVE_RUBY_BACKWARD_CLASSEXT_H'
end

if RUBY_VERSION >= '2.1.0'
  $CFLAGS << ' -DRUBY_V2_1_0'
end

create_makefile('uninclude/uninclude')
