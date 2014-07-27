PORT := /opt/local/bin/port

all: script vim binaries github-ssh pia bro portprogs lang git clean-pia prefs

binaries: chrome iterm notation skim skype pia

script: bro pip

lang: go-pkg hask-pkg yesod

portprogs: erlang latex pastebin transmission vlc

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

erlang: ensure-ports
	$(PORT) -v install erlang +wxwidgets

git:
	git config --global user.name "Tim Holland"
	git config --global user.email "th0114nd@gmail.com"

# Need to manually paste key in, but it's already in the clipboard.
github-ssh:
	zsh github-ssh.zsh
	open https://github.com/settings/ssh
	curl -L -o /tmp/github.zip \
	        -O https://central.github.com/mac/latest
	unzip /tmp/github.zip -d /Applications
	rm -rf /tmp/github.zip

golang: hg
	hg clone -u release https://code.google.com/p/go /tmp/go || true
	cd /tmp/go/src && ./all.bash
#	curl -L -o /tmp/go1.3.src.tar.gz \
#	        -O http://golang.org/dl/go1.3.src.tar.gz

go-pkg:
	curl -L -o /tmp/go.pkg \
	        -O http://golang.org/dl/go1.3.darwin-amd64-osx10.8.pkg
	installer -pkg /tmp/go.pkg -target /
	rm -rf /tmp/go.pkg
	mkdir ~/go

haskell: ensure-ports
	$(PORT) install ghc hs-cabal-install

hask-pkg:
	curl -L -o /tmp/hask.pkg \
	        -O http://www.haskell.org/platform/download/2013.2.0.0/Haskell%20Platform%202013.2.0.0%2064bit.pkg
	installer -pkg /tmp/hask.pkg -target /
	rm -rf /tmp/hask.pkg
	cabal update
	cabal install cabal-install

hg: ensure-ports
	$(PORT) install mercurial

iterm:
	curl -L -o /tmp/iterm.zip \
	        -O http://iterm2.com/downloads/stable/iTerm2_v2_0.zip 
	rm -rf /Applications/iTerm.app
	unzip /tmp/iterm.zip -d /Applications
	rm -rf /tmp/iterm.zip

latex: ensure-ports
	$(PORT) -v install latexmk texlive-latex-extra texlive-fonts-recommended

notation:
	curl -L -o /tmp/notvel.zip \
	        -O http://notational.net/NotationalVelocity.zip
	rm -rf "/Applications/Notational Velocity.app"
	rm -rf /Applications/__MACOSX
	unzip /tmp/notvel.zip -d /Applications
	rm /tmp/notvel.zip
	rm -rf /Applications/__MACOSX

pastebin: ensure-ports
	$(PORT) install pastebinit

pia:
	curl -L -o /tmp/installer_osx.dmg \
		-O https://www.privateinternetaccess.com/installer/installer_osx.dmg
	hdiutil mount -nobrowse /tmp/installer_osx.dmg
	rm -rf "/Applications/Private Internet Access.app"
	rm -rf /tmp/pia*
	open https://mail.google.com/mail/u/0/#search/private+internet+access/14582442981bd2b0
	open "/Volumes/Private Internet Access/Private Internet Access Installer.app"
	say "You're attention please."

clean-pia:
	hdiutil unmount /Volumes/Private*
	rm -rf /tmp/installer_osx.dmg

pip:
	easy_install pip

ensure-ports:
	test -e $(PORT)  || make ports

ports:
	xcode-select --install || true
	curl -L -o /tmp/macports.tgz \
	        -O https://distfiles.macports.org/MacPorts/MacPorts-2.3.1.tar.gz
	tar -xvzf /tmp/macports.tgz -C /tmp
	cd /tmp/Macports-2.3.1/ && ./configure && make && make install
	$(PORT) -v selfupdate
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
			
transmission: ensure-ports
	curl -L -o /tmp/transmission.dmg \
			-O https://transmission.cachefly.net/Transmission-2.84.dmg
	hdiutil mount -nobrowse /tmp/transmission.dmg
	rm -rf /Applications/Transmission.app
	cp -R /Volumes/Transmission-2.84/Transmission.app /Applications
	hdiutil unmount /Volumes/Transmission-2.84
	rm -rf /tmp/vlc.dmg
	#$(PORT) -v install transmission

update: vundler prezto
	$(PORT) -v selfupdate
	$(PORT) -v upgrade outdated
	gem update all
	cabal update

vim: dot vundler
	vim +PluginInstall +qall

vlc: ensure-ports
	curl -L -o /tmp/vlc.dmg \
			-O http://www.gtlib.gatech.edu/pub/videolan/vlc/2.1.5/macosx/vlc-2.1.5.dmg
	hdiutil mount -nobrowse /tmp/vlc.dmg
	rm -rf /Applications/VLC.app
	cp -R /Volumes/vlc-2.1.5/VLC.app /Applications
	hdiutil unmount /Volumes/vlc-2.1.5
	rm -rf /tmp/vlc.dmg
	#$(PORT) -fv install vlc

vundler:
	(test -d ~/.vim/bundle/Vundle.vim/.git && \
		cd ~/.vim/bundle/Vundle.vim/ && \
		git pull origin master) \
	|| git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim

yesod:
	cabal install yesod-platform yesod-bin --max-backjumps=-1 --reorder-goals

yosemite:
	cd "/Applications/Install OS X Yosemite Beta.app/Contents/Resources" && \
	    ./createinstallmedia \
	        --volume /Volumes/PEN \
	        --applicationpath "/Applications/Install OS X Yosemite Beta.app" \
	        --nointeraction

.IGNORE: clean-uninstall

clean-uninstall:
	gem uninstall bro
	chsh -s /bin/bash tim
	rm -rf ~/.vim/
	rm -rf ~/.z*
	rm -rf .ghc
	rm -rf /Applications/GitHub
	rm -rf "/Applications/Google Chrome.app"
	rm -rf /Applications/iTerm.app
	rm -rf "/Applications/Notational Velocity.app"
	rm -rf "/Applications/Private Internet Access.app"
	rm -rf /Applications/Skype.app
	rm -rf /Applications/Xcode.app
	/Library/Haskell/bin/uninstall-hs thru 7.6.3 --remove
	rm -rf /Library/Haskell
	rm -rf /usr/local/go
	rm -rf /etc/paths.d/go
	rm -rf /opt
	rm -rf /tmp/macports* /tmp/MacPorts*
	rm -rf /Applications/MacPorts/
	rm -rf ~/.bro
