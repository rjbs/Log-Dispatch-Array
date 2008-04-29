use inc::Module::Install;
all_from('lib/Log/Dispatch/Array.pm');
requires('Log::Dispatch::Output' => 0);
test_requires('Test::Deep' => 0);
extra_tests;
WriteAll;
