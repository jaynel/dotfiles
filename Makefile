all: dot pip bro erlang haskell prezto transmission vim vlc

bro:
	gem install bropages

dot: prezto
	ln -fv .zshrc ~/.zshrc
	ln -fv .zshenv ~/.zshenv
	ln -fv .vimrc ~/.vimrc

erlang: ports
	port -v install erlang

haskell: ports
	port install ghc hs-cabal-install

latexmk: ports
	port -v install latexmk texlive-latex-extra texlive-fonts-recommended

pip:
	easy_install pip

ports:
	curl -o /tmp/macports.tgz \
		https://distfiles.macports.org/MacPorts/MacPorts-2.3.1.tar.gz
	tar -xvzf /tmp/macports.tgz -C /tmp
	cd /tmp/Macports-2.3.1/ && ./configure && make && make install
	/opt/local/bin/port -v selfupdate

prezto:
	zsh getprezto.zsh

solarized:
	rm -rf ~/.vim/bundle/vim-colors-solarized
	git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized

transmission: ports
	port -v install transmission

vim: vundler
	echo ":quit" | vim -c PluginInstall

vlc: ports
	port -v install vlc

vundler:
	git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim

.IGNORE: clean-uninstall

clean-uninstall:
	pip uninstall powerline
	chsh -s /bin/bash
	rm -rf /Library/Python/2.7/site-packages/pip*.egg
	rm -rf /usr/local/bin/pip*
	rm -rf ~/.vim/bundle ~/.vim/autoload
	rm -rf ~/.z*
	rm -rf /opt
	rm -rf /tmp/macports* /tmp/MacPorts*
	rm -rf /Applications/MacPorts/
	gem uninstall bro
