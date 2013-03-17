require 'mkmf'

RbConfig::MAKEFILE_CONFIG['CC'] = ENV['CC'] if ENV['CC']

$CFLAGS << " #{ENV["CFLAGS"]}"

if RUBY_VERSION >= '1.9.3'
  $CFLAGS << ' -DHAVE_RUBY_BACKWARD_CLASSEXT_H'
end

create_makefile('uninclude/uninclude')
