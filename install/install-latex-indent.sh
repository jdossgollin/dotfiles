curl -L https://install.perlbrew.pl | bash

perlbrew init
perlbrew --notest install perl-5.16.0
perlbrew install perl-5.16.0
perlbrew switch perl-5.16.0

curl -L http://cpanmin.us | perl - App::cpanminus
cpanm YAML::Tiny
cpanm File::HomeDir
cpanm Unicode::GCString
cpanm Log::Log4perl
cpanm Log::Dispatch
