require 'pygments'

if !!RUBY_PLATFORM['linux']
    RubyPython.configure :python_exe => 'python2'
end
