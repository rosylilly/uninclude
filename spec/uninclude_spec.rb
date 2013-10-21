require 'spec_helper'
require 'timeout'

module ExampleMod
  def mod; :mod; end
end

describe Uninclude do
  let(:klass) {
    Class.new do
    end
  }
  let(:instance) { klass.new }

  describe '.uninclude' do
    it 'should uninclude module' do
      klass.class_eval { include ExampleMod }
      instance.should respond_to(:mod)
      klass.class_eval { uninclude ExampleMod }
      instance.should_not respond_to(:mod)
    end

    it 'should not infinite loop' do
      klass.class_eval { uninclude(Module.new) }
    end
  end

  describe '#unextend' do
    it 'should unextend module' do
      instance.extend(ExampleMod)
      instance.should respond_to(:mod)
      instance.unextend(ExampleMod)
      instance.should_not respond_to(:mod)
    end
  end
end
