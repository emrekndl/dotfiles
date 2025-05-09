
export CHROME_EXECUTABLE='/usr/bin/chromium'
# Perl
PATH="/home/emre/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/emre/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/emre/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/emre/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/emre/perl5"; export PERL_MM_OPT;
# rofi
export PATH=$HOME/.config/rofi/scripts:$PATH
# rust cargo
export PATH="$HOME/.cargo/bin:$PATH"
# go
export GOPATH=$HOME/go
export GOROOT=/usr/lib/go
PATH=$PATH:$GOROOT/bin:$GOPATH/bin


# java
export JAVA_HOME='/usr/lib/jvm/java-21-openjdk'
export PATH=$JAVA_HOME/bin:$PATH 

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

# Created by `pipx` on 2024-09-26 16:32:23
export PATH="$PATH:/home/emre/.local/bin"

# pfetch
