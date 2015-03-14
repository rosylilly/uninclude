# -*- coding: utf-8 -*-
require 'uninclude/uninclude'

class Module
  alias_method :__include, :include
  alias_method :__uninclude, :uninclude
  
  def include(mod)

    __include(mod)

    if block_given?
      yield(self)
      __uninclude(mod)
    end
  end

  def uninclude(mod)
    return unless ancestors.include?(mod)

    __uninclude(mod)

    if block_given?
      yield(self)
      __include(mod)
    end
  end
end

class Object
  alias_method :__extend, :extend
  alias_method :__unextend, :unextend

  def extend(mod)

    __extend(mod)

    if block_given?
      yield(self)
      __unextend(mod)
    end
  end

  def unextend(mod)
    return unless self.singleton_class.ancestors.include?(mod)

    __unextend(mod)

    if block_given?
      yield(self)
      __extend(mod)
    end
  end

end
