brew update
brew upgrade

brew cask install \
	iterm2 \
	google-chrome \
	backblaze \
	bettertouchtool \
	spotify \
	whatsapp \
	dropbox \
	caffeine \
	flux \
	zotero \
        skim \
        mactex

brew install \
	git \
	nvim \
	gcc \
        cmake \
        ninja \
        openblas \
        ghc

python3 -m pip install --user --upgrade pip
python3 -m pip install --user Pygments
