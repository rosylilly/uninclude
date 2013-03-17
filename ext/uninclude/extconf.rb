require 'mkmf'

if RUBY_VERSION >= '1.9.3'
  $CFLAGS << ' -DHAVE_RUBY_BACWARD_CLASSEXT_H'
end

create_makefile('uninclude/uninclude')
