{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # 1. Ferramentas de Build (necessárias para compilar extensões nativas)
  nativeBuildInputs = with pkgs; [
    pkg-config  # Ajuda as gems a encontrarem as bibliotecas no sistema
    gcc         # Compilador C
    gnumake     # Ferramenta make
  ];

  # 2. Dependências do Projeto (Linguagens e Bibliotecas)
  buildInputs = with pkgs; [
    ruby_3_3    # Garante a versão correta do Ruby
    bundler

    # Bibliotecas de Sistema Necessárias para Gems Nativas
    libyaml     # Para a gem 'psych' (seu erro atual)
    sqlite      # Para a gem 'sqlite3'
    libxml2     # Para a gem 'nokogiri'
    libxslt     # Para a gem 'nokogiri'

    # Opcionais (mas úteis para Rails)
    nodejs      # Para compilar assets JS se necessário
    yarn
    # postgresql # Descomente se for usar banco Postgres no futuro
  ];

  # 3. Configurações de Ambiente
  shellHook = ''
    echo "Ambiente de Desenvolvimento Rails carregado! 🚀"
    echo "Ruby: $(ruby --version)"

    # Opcional: Define onde as gems serão instaladas localmente para não poluir o sistema
    # Isso cria a pasta .nix-gems que ignoramos no git antes
    export GEM_HOME=$PWD/.nix-gems
    export PATH=$GEM_HOME/bin:$PATH
    export PATH=$PWD/bin:$PATH
  '';
}
