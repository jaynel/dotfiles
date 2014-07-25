all: script binaries github-ssh dot bro portprogs git vim prefs

binaries: chrome iterm notation skim skype xcode

script: bro pip

portprogs: erlang haskell transmission vlc

bro:
	gem install bropages

chrome:
	curl -L -o /tmp/googlechrome.dmg \
			-O https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg
	hdiutil mount -nobrowse /tmp/googlechrome.dmg
	rm -rf "/Applications/Google Chrome.app"
	cp -R "/Volumes/Google Chrome/Google Chrome.app" /Applications
	hdiutil unmount "/Volumes/Google Chrome"
	rm /tmp/googlechrome.dmg

dot: prezto
	ln -fv .zshrc ~/.zshrc
	ln -fv .zshenv ~/.zshenv
	ln -fv .vimrc ~/.vimrc

erlang: ports
	port -v install erlang

git:
	git config --global user.name "Tim Holland"
	git config --global user.email "th0114nd@gmail.com"

github-ssh:
	zsh github-ssh.zsh
	open https://github.com/settings/ssh

haskell: ports
	port install ghc hs-cabal-install

iterm:
	curl -L -o /tmp/iterm.zip \
			-O http://iterm2.com/downloads/stable/iTerm2_v2_0.zip 
	rm -rf /Applications/iTerm.app
	unzip /tmp/iterm.zip -d /Applications
	rm -rf /tmp/iterm.zip

latexmk: ports
	port -v install latexmk texlive-latex-extra texlive-fonts-recommended

notation:
	curl -L -o /tmp/notvel.zip \
			-O http://notational.net/NotationalVelocity.zip
	rm -rf /Applications/NotationalVelocity.app
	unzip /tmp/notvel.zip -d /Applications
	rm /tmp/notvel.zip

pip:
	easy_install pip

ports:
	xcode-select --install
	curl -o /tmp/macports.tgz \
		https://distfiles.macports.org/MacPorts/MacPorts-2.3.1.tar.gz
	tar -xvzf /tmp/macports.tgz -C /tmp
	cd /tmp/Macports-2.3.1/ && ./configure && make && make install
	/opt/local/bin/port -v selfupdate
	rm -rf ~/.profile

.PHONY: prefs
prefs:
	zsh makeprefs.zsh

prezto:
	zsh getprezto.zsh

skim:
	curl -L -o /tmp/skim.dmg \
			-O http://downloads.sourceforge.net/project/skim-app/Skim/Skim-1.4.1/Skim-1.4.1.dmg?use_mirror=autoselect
	hdiutil mount -nobrowse /tmp/skim.dmg
	rm -rf /Applications/Skim.app
	cp -fR /Volumes/Skim/Skim.app /Applications
	hdiutil unmount /Volumes/Skim
	rm /tmp/skim.dmg

skype:
	curl -L -o /tmp/skype.dmg \
			-O http://www.skype.com/go/getskype-macosx.dmg
	hdiutil mount -nobrowse /tmp/skype.dmg
	rm -rf /Applications/Skype.app
	cp -fR /Volumes/Skype/Skype.app /Applications
	hdiutil unmount /Volumes/Skype
	rm /tmp/skype.dmg

spectacle:
	curl -L -o /tmp/spectacle.zip \
			-O https://s3.amazonaws.com/spectacle/downloads/Spectacle+0.8.5.zip
	rm -rf /Applications/Spectacle.app
	unzip /tmp/spectacle.zip -d /Applications
	rm -rf /tmp/spectacle.zip

			
transmission: ports
	port -v install transmission

xcode:
	sh getxcode.sh https://developer.apple.com/devcenter/download.action?path=/Developer_Tools/xcode_6_beta_4_o2p8fz/xcode_6_beta_4.dmg
	
	
vim: vundler
	echo ":quit" | vim -c PluginInstall

vlc: ports
	port -v install vlc

vundler:
	git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim

.IGNORE: clean-uninstall

clean-uninstall:
	gem uninstall bro
	pip uninstall powerline
	chsh -s /bin/bash
	rm -rf /Library/Python/2.7/site-packages/pip*.egg
	rm -rf /usr/local/bin/pip*
	rm -rf ~/.vim/
	rm -rf ~/.z*
	rm -rf .ghc
	rm -rf "/Applications/Google Chrome.app"
	rm -rf /Applications/iTerm.app
	rm -rf /Applications/NotationalVelocity.app
	rm -rf /Applications/Skype.app
	rm -rf /Applications/Xcode.app
	rm -rf /opt
	rm -rf /tmp/macports* /tmp/MacPorts*
	rm -rf /Applications/MacPorts/
	rm -rf ~/.bro
