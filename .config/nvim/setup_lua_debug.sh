git clone https://github.com/tomblind/local-lua-debugger-vscode \
  ~/.local/share/local-lua-debugger-vscode

cd ~/.local/share/local-lua-debugger-vscode
npm install
npm run build

lua -v
node --version
npm --version
