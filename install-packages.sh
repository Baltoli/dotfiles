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
        ghc \
        pypy3 \
        pypy \
        conan \
        clang-format \
        the_silver_searcher

python3 -m pip install --user --upgrade pip
python3 -m pip install --user Pygments
