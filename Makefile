all: dot ports vim bro erlang vlc transmission

erlang:
	port -v install erlang

dot:
	ln -fv .zshrc ~/.zshrc
	ln -fv .zshenv ~/.zshenv
	ln -fv .vimrc ~/.vimrc

prezto:
	zsh getprezto.zsh

vim: pathogen powerline solarized

solarized:
	rm -rf ~/.vim/bundle/vim-colors-solarized
	git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized

curl: ports
	port -v install curl

vlc: ports
	port -v install vlc

latexmk: ports
	port -v install latexmk texlive-latex-extra texlive-fonts-recommended

transmission: ports
	port -v install transmission

powerline: pip
	pip install --user git+git://github.com/Lokaltog/powerline 

pathogen: curl
	mkdir -p ~/.vim/autoload ~/.vim/bundle
	curl  -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

pip:
	easy_install pip

vundler:
	git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim

hask:
	port install ghc hs-cabal-install

bro:
	gem install bropages

ports:
	curl -o /tmp/macports.tgz https://distfiles.macports.org/MacPorts/MacPorts-2.3.1.tar.gz
	tar -xvzf /tmp/macports.tgz -C /tmp
	cd /tmp/Macports-2.3.1/ && ./configure && make && make install
	/opt/local/bin/port -v selfupdate

.IGNORE: clean-uninstall

clean-uninstall:
	pip uninstall powerline
	rm -rf /Library/Python/2.7/site-packages/pip*.egg
	rm -rf /usr/local/bin/pip*
	rm -rf ~/.vim/bundle ~/.vim/autoload
	rm -rf /opt
	rm -rf /tmp/macports* /tmp/MacPorts*
	rm -rf /Applications/MacPorts/
	port uninstall --follow-dependents ghc hs-cabal-install curl
	gem uninstall bro
