brew update
brew upgrade

brew cask install \
	iterm2 \
	google-chrome \
	backblaze \
	bettertouchtool \
	spotify \
        spotify-notifications \
	whatsapp \
	dropbox \
	caffeine \
	flux \
	zotero \
        skim \
        mactex \
        daisydisk \
        tunnelblick

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
        the_silver_searcher \
        ccache \
        coreutils \
        bash

python3 -m pip install --user --upgrade pip
python3 -m pip install --user Pygments
