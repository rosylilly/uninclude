require 'spec_helper'
require 'timeout'

module ExampleMod
  def mod; :mod; end
end

describe Uninclude do
  let(:klass) {
    Class.new do
      def singleton_class
        class << self
          self
        end
      end
    end
  }
  let(:instance) { klass.new }

  describe '.uninclude' do
    it 'should uninclude module' do
      klass.class_eval { include ExampleMod }
      expect(instance).to respond_to(:mod)
      expect(instance.mod).to equal(:mod)
      expect(klass.ancestors).to include(ExampleMod)
      klass.class_eval { uninclude ExampleMod }
      expect(instance).to_not respond_to(:mod)
      expect(klass.ancestors).to_not include(ExampleMod)
    end

    it 'should not infinite loop' do
      klass.class_eval { uninclude(Module.new) }
    end
  end

  if Module.respond_to?(:prepend)
    describe '.unprepend' do
      it 'should unprepend module' do
        klass.class_eval { prepend ExampleMod }
        expect(instance).to respond_to(:mod)
        expect(instance.mod).to equal(:mod)
        expect(klass.ancestors).to include(ExampleMod)
        klass.class_eval { unprepend ExampleMod }
        expect(instance).to_not respond_to(:mod)
        expect(klass.ancestors).to_not include(ExampleMod)
      end
    end
  end

  describe '#unextend' do
    it 'should unextend module' do
      instance.extend(ExampleMod)
      expect(instance).to respond_to(:mod)
      expect(instance.mod).to equal(:mod)
      expect(instance.singleton_class.ancestors).to include(ExampleMod)
      instance.unextend(ExampleMod)
      expect(instance).to_not respond_to(:mod)
      expect(instance.singleton_class.ancestors).to_not include(ExampleMod)
    end
  end
end
