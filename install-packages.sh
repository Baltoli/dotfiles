brew update
brew upgrade
brew bundle

python3 -m pip install --user --upgrade pip
python3 -m pip install --user \
  Pygments      \
  candl-lexer   \
  graphviz      \
  hole-c-lexer  \
  lit           \
  pymupdf       \
  tabulate      \
  virtualenv    \
  wllvm

gem install --user bundler
