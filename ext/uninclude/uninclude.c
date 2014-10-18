#include <ruby.h>

#ifdef HAVE_RUBY_BACKWARD_CLASSEXT_H
#include <ruby/backward/classext.h>
#endif

#ifndef RCLASS_M_TBL
#define RCLASS_M_TBL(c) (RCLASS(c)->m_tbl)
#endif

#ifndef RB_CLEAR_CACHE_BY_CLASS
#define RB_CLEAR_CACHE_BY_CLASS(c) rb_clear_cache_by_class(c)
#endif

#ifdef RUBY_V2_1_0
#undef RCLASS_M_TBL
#define RCLASS_M_TBL(c) (RCLASS(c)->m_tbl_wrapper)
#undef RB_CLEAR_CACHE_BY_CLASS
#define RB_CLEAR_CACHE_BY_CLASS(c) rb_clear_method_cache_by_class(c)
#endif

static void uninclude(VALUE klass, VALUE mod) {
  Check_Type(mod, T_MODULE);

  VALUE superklass = RCLASS_SUPER(klass);
  VALUE lastklass = 0;
  for(; superklass; klass = superklass, klass = RCLASS_SUPER(klass)) {
    if(lastklass == klass) break;
    if(klass == mod || RCLASS_M_TBL(superklass) == RCLASS_M_TBL(mod)) {
      RCLASS_SUPER(klass) = RCLASS_SUPER(superklass);
      RB_CLEAR_CACHE_BY_CLASS(klass);
      break;
    }
    lastklass = klass;
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
