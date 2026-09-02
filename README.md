# NVIM CHEP CONFIG

> Configuração de NeoVim simples com suporte a uma série de linguagens.

```text
███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██║   ██║██║████╗ ████║
██╔██╗ ██║██║   ██║██║██╔████╔██║                                                    por rafaaahype ;p
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
```


---
## Sumário
* [Sobre a Configuração](#sobre-a-configuração)
* [Como Instalar](#como-instalar)
* [Como Utilizar](#como-utilizar)
* [Atualizações Futuras](#atualizações-futuras)
* [Desenvolvedor](#desenvolvedor)

---

## Sobre a Configuração
Esta configuração visa fornecer suporte e ferramenta à algumas linguagens de programação e de marcação dentro do editor de código NeoVim. Por sua vez, ela evolui ao longo da minha necessidade enquanto estudante no curso superior tecnólogo de Análise e Desenvolvimento de Sistemas, todas as linguagens que esta configuração suporta vem diretamente das minhas necessidades enquanto desenvolvedor. Fique à vontade para modificar e distribuir gratuitamente. Caso tenha alguma sugestão, manda uma issue! :D

---

### Como Instalar
Para instalar no seu computador esta configuração, será necessário que a sua máquina possua os seguintes softwares instalados previamente nela:
* Neovim (v0.8+)
* Git
* GCC ou CLang
* Ripgrep
* Fd-find
* Node.js e npm
* Java JDK
* Arduino CLI
* Unzip, Tar e Curl
* Xclip

Para instalar tudo de uma vez utilizando apenas um comando, irei disponibilizar cada comando para os gerenciadores mais populares de distribuições Linux:

[pacman]
```bash
sudo pacman -Syu neovim git gcc ripgrep fd nodejs npm jdk-openjdk arduino-cli unzip xclip
```
[apt]
```bash
sudo apt update && sudo apt install -y neovim git gcc ripgrep fd-find nodejs npm openjdk-17-jdk unzip xclip
```

[dnf]
```bash
sudo dnf install -y neovim git gcc ripgrep fd-find nodejs npm java-latest-openjdk-devel unzip xclip
```

[zypper]
```bash
sudo zypper install -y neovim git gcc ripgrep fd nodejs npm java-17-openjdk-devel unzip xclip
```

[apk]
```bash
apk add neovim git gcc ripgrep fd nodejs npm openjdk17 unzip xclip
```
---
Distribuições que tem como base o ArchLinux já vem com o ```arduino-cli``` como uma das suas opções no gerenciador de pacotes. Caso você esteja em uma distro que não tenha ele no seu gerenciador de pacotes padrão, execute este comando:
```bash
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
```
---

Após isso, você deverá acessar o diretório ```~/.config/```:
```bash
mkdir -p ~/.config/ && cd ~/.config/
```
E depois clonar este repositório:
```bash
git clone https://github.com/rafaaahype/nvim-chep-config
```

Observação! Antes de executar o código a seguir, caso você já tenha usado previamente alguma outra configuração de Neovim e queria substituir por esta, lembre-se de utilizar: 
```bash
rm -rf ~/.config/nvim
```

Renomeie o nome do repositório para ```nvim```:
```bash
mv nvim-chep-config/ nvim/
```

---

## Como Utilizar


---

## Atualizações Futuras
As futuras atualizações dessas configurações terão influência direta de certas issues que aparecerem neste repositório e da minha necessidade pessoal enquanto desenvolvedor.

## Desenvolvedor
Rafael Vieira (aka rafaaahype)
