# -*- coding: utf-8 -*-
$: << File.join(File.dirname(File.expand_path(__FILE__)), '..', 'lib')
require 'clean_css'

describe CleanCss do
  let(:fixture_css) { <<-END_CSS
      div.warning {
        display: none;
      }

      div.error {
        background: red;
        color: white;
      }

      @media screen and (max-device-width: 640px) {
        body { font-size: 90%; }
      }
    END_CSS
  }

  let(:compressed_css) {
    'div.warning{display:none}div.error{background:red;color:#fff}@media screen and (max-device-width: 640px){body{ font-size:90%}}'
  }

  describe '.initialize' do
    context 'no options were given' do
      subject { described_class.new }
      its(:command) { should == 'cleancss' }
    end
    context 'option :command was given' do
      let(:options) { { command: '/path/to/cleancss' } }
      subject { described_class.new(options) }
      its(:command) { should == options[:command] }
    end
 end

  describe '#compress' do
    context 'fixture css was given as string' do
      subject { described_class.new.compress fixture_css }
      it { should == compressed_css }
    end

    context 'fixture css was given as stream' do
      subject { described_class.new.compress StringIO.new(fixture_css) }
      it { should == compressed_css }
    end

    context 'fixture css was given as block' do
      it 'yields an IO' do
        described_class.new.compress(fixture_css) do |stream|
          stream.should be_instance_of IO
          stream.read.should == compressed_css
        end
      end
    end
  end
end
