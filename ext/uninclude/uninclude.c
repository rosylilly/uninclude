#include <ruby.h>
#include <ruby/backward/classext.h>

#define RCLASS_M_TBL(c) (RCLASS(c)->m_tbl)

static void uninclude(VALUE klass, VALUE mod) {
  Check_Type(mod, T_MODULE);

  VALUE superklass = RCLASS_SUPER(klass);
  for(; superklass; klass = superklass, klass = RCLASS_SUPER(klass)) {
    if(klass == mod || RCLASS_M_TBL(superklass) == RCLASS_M_TBL(mod)) {
      RCLASS_SUPER(klass) = RCLASS_SUPER(superklass);
      rb_clear_cache_by_class(klass);
      break;
    }
  };
};

static VALUE rb_m_uninclude(VALUE self, VALUE mod) {
  uninclude(self, mod);
  return self;
}

static VALUE rb_m_unextend(VALUE self, VALUE mod) {
  uninclude(rb_singleton_class(self), mod);
  return self;
}

void Init_uninclude(void) {
  rb_define_private_method(rb_cModule, "uninclude", RUBY_METHOD_FUNC(rb_m_uninclude), 1);
  rb_define_method(rb_cObject, "unextend", RUBY_METHOD_FUNC(rb_m_unextend), 1);
}
