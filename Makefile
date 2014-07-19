all: dot vim

dot:
	ln -s ./.zshrc ~/.zshrc
	ln -s ./.vimrc ~/.vimrc

vim: pathogen powerline solarized

solarized:
	cd ~/.vim/bundle
	git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized

curl:
	port install curl

powerline: pip
	pip install --user git+git://github.com/Lokaltog/powerline 

pathogen: curl
	mkdir -p ~/.vim/autoload ~/.vim/bundle
	curl  -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

pip:
	easy_install pip

clean:
	pip uninstall powerline
	rm -rf /Library/Python/2.7/site-packages/pip*.egg
	rm -rf ~/.vim/bundle ~/.vim/autoload
